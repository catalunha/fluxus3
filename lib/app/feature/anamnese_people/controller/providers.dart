import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_answer_model.dart';
import '../../../core/models/anamnese_group_model.dart';
import '../../../core/models/anamnese_people_model.dart';
import '../../../data/b4a/entity/anamnese_answer_entity.dart';
import '../../../data/b4a/entity/anamnese_group_entity.dart';
import '../../../data/b4a/entity/anamnese_people_entity.dart';
import '../../../data/b4a/entity/anamnese_question_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<AnamnesePeopleModel>> anamnesePeopleList(
    AnamnesePeopleListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamnesePeopleEntity.className));
  query.orderByAscending('name');
  final list =
      await ref.watch(anamnesePeopleRepositoryProvider).list(query, cols: {
    "${AnamnesePeopleEntity.className}.cols": [
      AnamnesePeopleEntity.createdAt,
      AnamnesePeopleEntity.adultName,
      AnamnesePeopleEntity.adultPhone,
      AnamnesePeopleEntity.childName,
      AnamnesePeopleEntity.childIsFemale,
      AnamnesePeopleEntity.childBirthDate,
    ],
  });
  return list;
}

@riverpod
class AnamnesePeopleSearch extends _$AnamnesePeopleSearch {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@riverpod
FutureOr<List<AnamnesePeopleModel>> anamnesePeopleFiltered(
    AnamnesePeopleFilteredRef ref) {
  final search = ref.watch(anamnesePeopleSearchProvider);
  final data = ref.watch(anamnesePeopleListProvider);

  // return data
  //     .where((element) => (element.childName.toLowerCase().contains(search)))
  //     .toList();
  // // return AsyncValue.data([]);
  return data.when(data: (data2) {
    return data2
        .where((element) => (element.childName.toLowerCase().contains(search)))
        .toList();
  }, error: (error, st) {
    return [];
  }, loading: () {
    return [];
  });
}

// @riverpod
// class AnamneseAnswerStatusState extends _$AnamneseAnswerStatusState {
//   @override
//   AnamneseAnswerStatus build() {
//     return AnamneseAnswerStatus.initial;
//   }

//   void set(AnamneseAnswerStatus value) {
//     state = value;
//   }
// }

@riverpod
FutureOr<List<AnamneseAnswerModel>> anamneseAnswerList(
    AnamneseAnswerListRef ref) async {
  // +++ Listando Answer
  QueryBuilder<ParseObject> queryAnswer =
      QueryBuilder<ParseObject>(ParseObject(AnamneseAnswerEntity.className));
  queryAnswer.orderByAscending('name');
  final listAnswer = await ref
      .watch(anamneseAnswerRepositoryProvider)
      .list(queryAnswer, cols: {
    "${AnamneseAnswerEntity.className}.cols": [
      AnamneseAnswerEntity.people,
      AnamneseAnswerEntity.question,
      AnamneseAnswerEntity.answer,
    ],
    "${AnamneseAnswerEntity.className}.pointers": [
      AnamneseAnswerEntity.people,
      AnamneseAnswerEntity.question,
      '${AnamneseAnswerEntity.question}.${AnamneseQuestionEntity.anamneseGroup}',
    ],
  });
  // --- Listando Answer
  // +++ Listando Group
  QueryBuilder<ParseObject> queryGroups =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  queryGroups.orderByAscending('name');
  final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
    queryGroups,
    cols: {
      "${AnamneseGroupEntity.className}.cols": [
        AnamneseGroupEntity.name,
        // AnamneseGroupEntity.description,
        // AnamneseGroupEntity.isActive,
        AnamneseGroupEntity.orderOfQuestions,
      ],
    },
  );
  var anamnese =
      await ref.read(anamneseRepositoryProvider).readByName('orderOfGroups');
  var listGroupsOrdened = <AnamneseGroupModel>[];
  final Map<String, AnamneseGroupModel> mapping = {
    for (var group in listGroups) group.id!: group
  };
  for (var groupId in anamnese!.orderOfGroups) {
    listGroupsOrdened.add(mapping[groupId]!);
  }
  // --- Listando Group
  // +++ Listando Question
  QueryBuilder<ParseObject> queryQuestions =
      QueryBuilder<ParseObject>(ParseObject(AnamneseQuestionEntity.className));
  queryQuestions.orderByAscending('text');
  final listQuestions = await ref.read(anamneseQuestionRepositoryProvider).list(
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
  // --- Listando Question

  return listAnswer;
}

@Riverpod(keepAlive: true)
class AnamnesePeopleSelected extends _$AnamnesePeopleSelected {
  @override
  AnamnesePeopleModel? build() {
    return null;
  }

  void set(AnamnesePeopleModel value) {
    state = value;
  }
}

// @Riverpod(keepAlive: true)
// class AnamneseAnswerListSelected extends _$AnamneseAnswerListSelected {
//   @override
//   List<AnamneseAnswerModel> build() {
//     return [];
//   }

//   void set(List<AnamneseAnswerModel> value) {
//     state = value;
//   }
// }
