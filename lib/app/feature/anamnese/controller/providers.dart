import 'dart:developer';

import 'package:fluxus3/app/core/models/anamnese_question_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_group_model.dart';
import '../../../core/models/anamnese_model.dart';
import '../../../core/models/anamnese_people_model.dart';
import '../../../core/repositories/providers.dart';
import '../../../data/b4a/entity/anamnese_group_entity.dart';
import '../../../data/b4a/entity/anamnese_question_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class ReadAllQuestions extends _$ReadAllQuestions {
  @override
  FutureOr<List<AnamneseQuestionModel>> build() async {
    //Lendo os grupos e colocando em ordem
    QueryBuilder<ParseObject> queryGroups =
        QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
    queryGroups.orderByAscending('name');
    final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
      queryGroups,
      cols: {
        "${AnamneseGroupEntity.className}.cols": [
          AnamneseGroupEntity.name,
          AnamneseGroupEntity.description,
          AnamneseGroupEntity.isActive,
          AnamneseGroupEntity.orderOfQuestions,
        ],
      },
    );
    var anamnese =
        await ref.read(anamneseRepositoryProvider).readByName('orderOfGroups');
    var listGroupsOrdened = <AnamneseGroupModel>[];
    if (anamnese != null && anamnese.orderOfGroups.isNotEmpty) {
      final Map<String, AnamneseGroupModel> mapping = {
        for (var group in listGroups) group.id!: group
      };
      for (var groupId in anamnese.orderOfGroups) {
        listGroupsOrdened.add(mapping[groupId]!);
      }
    } else {
      if (listGroups.isNotEmpty) {
        await ref.read(anamneseRepositoryProvider).save(AnamneseModel(
            name: 'orderOfGroups',
            orderOfGroups: listGroups.map((e) => e.id!).toList()));
      }

      listGroupsOrdened = [...listGroups];
    }

    //Lendo as pergunta e ordenando pelos grupos

    QueryBuilder<ParseObject> queryQuestions = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    queryQuestions.orderByAscending('text');
    final listQuestions =
        await ref.read(anamneseQuestionRepositoryProvider).list(
      queryQuestions,
      cols: {
        "${AnamneseQuestionEntity.className}.cols": [
          AnamneseQuestionEntity.text,
          AnamneseQuestionEntity.description,
          AnamneseQuestionEntity.type,
          AnamneseQuestionEntity.isActive,
          AnamneseQuestionEntity.isRequired,
          AnamneseQuestionEntity.anamneseGroup,
        ],
        "${AnamneseQuestionEntity.className}.pointers": [
          AnamneseQuestionEntity.anamneseGroup,
        ],
      },
    );
    var questionsOrdered = <AnamneseQuestionModel>[];
    for (var group in listGroupsOrdened) {
      final questionsUnOrdered = listQuestions
          .where((element) => element.anamneseGroup.id == group.id)
          .toList();

      if (group.orderOfQuestions.isNotEmpty) {
        final Map<String, AnamneseQuestionModel> mapping = {
          for (var question in questionsUnOrdered) question.id!: question
        };
        for (var questionId in group.orderOfQuestions) {
          if (mapping.containsKey(questionId)) {
            questionsOrdered.add(mapping[questionId]!);
          }
        }
      } else {
        questionsOrdered.addAll([...questionsUnOrdered]);
      }
    }
    ref.read(indexEndProvider.notifier).set(questionsOrdered.length);
    ref.read(questionCurrentProvider.notifier).set(questionsOrdered[0]);
    return questionsOrdered;
  }

  AnamneseQuestionModel getQuestion(int value) {
    return state.requireValue[value];
  }
}

@Riverpod(keepAlive: true)
class QuestionCurrent extends _$QuestionCurrent {
  @override
  AnamneseQuestionModel? build() {
    return null;
  }

  void set(AnamneseQuestionModel value) {
    state = value;
  }
}

@riverpod
class AnswerTypeYesNo extends _$AnswerTypeYesNo {
  @override
  AnswerTypeYesNoStatus build() {
    return AnswerTypeYesNoStatus.none;
  }

  void set(AnswerTypeYesNoStatus value) {
    state = value;
  }
}

@riverpod
class AnswerText extends _$AnswerText {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class IndexEnd extends _$IndexEnd {
  @override
  int build() {
    return 0;
  }

  void set(int value) {
    state = value;
  }
}

@riverpod
bool canGoToIndexPrevious(CanGoToIndexPreviousRef ref) {
  return ref.watch(indexCurrentProvider) != 0;
}

@riverpod
bool inLastIndexCurrent(InLastIndexCurrentRef ref) {
  final indexEnd = ref.read(indexEndProvider);

  return ref.watch(indexCurrentProvider) == (indexEnd - 1);
}

@Riverpod(keepAlive: true)
class IndexCurrent extends _$IndexCurrent {
  @override
  int build() {
    return 0;
  }

  void previous() {
    if (state > 0) {
      state = state - 1;
      final question =
          ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
      ref.read(questionCurrentProvider.notifier).set(question);
    }
  }

  void next() {
    log('next: $state');
    final indexEnd = ref.read(indexEndProvider);
    if (state < (indexEnd - 1)) {
      state = state + 1;
      final question =
          ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
      ref.read(questionCurrentProvider.notifier).set(question);
      log('next: $state');
    }
  }
}

@riverpod
class ChildBirthDate extends _$ChildBirthDate {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class ChildIsFemale extends _$ChildIsFemale {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class AnamnesePeopleForm extends _$AnamnesePeopleForm {
  @override
  AnamnesePeopleFormState build() {
    return AnamnesePeopleFormState();
  }

  Future<void> submitForm({
    required String adultName,
    required String adultPhone,
    required String childName,
  }) async {
    state = state.copyWith(status: AnamnesePeopleFormStatus.loading);
    try {
      final childIsFemale = ref.read(childIsFemaleProvider);
      final childBirthDate = ref.read(childBirthDateProvider);

      final anamnesePeopleTemp = AnamnesePeopleModel(
        adultName: adultName,
        adultPhone: adultPhone,
        childName: childName,
        childIsFemale: childIsFemale,
        childBirthDate: childBirthDate!,
      );

      await ref.read(anamnesePeopleRepositoryProvider).save(anamnesePeopleTemp);

      state = state.copyWith(status: AnamnesePeopleFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamnesePeopleFormStatus.error,
          error: 'Erro em editar cargo');
    }
  }
}
