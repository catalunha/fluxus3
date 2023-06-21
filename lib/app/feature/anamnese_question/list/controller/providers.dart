import 'package:fluxus3/app/core/models/anamnese_group_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_question_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_group_entity.dart';
import '../../../../data/b4a/entity/anamnese_question_entity.dart';

part 'providers.g.dart';

@riverpod
class AnamneseQuestions extends _$AnamneseQuestions {
  @override
  Future<List<AnamneseQuestionModel>> build() async {
    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    query.orderByAscending('text');
    final listQuestions =
        await ref.read(anamneseQuestionRepositoryProvider).list(
      query,
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
    QueryBuilder<ParseObject> query2 =
        QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
    query2.orderByAscending('name');
    final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
      query2,
      cols: {
        "${AnamneseGroupEntity.className}.cols": [
          AnamneseGroupEntity.name,
          AnamneseGroupEntity.orderOfQuestions,
        ],
      },
    );
    ref.read(anamneseGroupListProvider.notifier).set(listGroups);

    /*
    var anamnese =
        await ref.read(anamneseRepositoryProvider).readByName('orderOfQuestions');
    var listQuestionsReordened = <AnamneseQuestionModel>[];
    if (anamnese != null && anamnese.orderOfQuestions.isNotEmpty) {
      final Map<String, AnamneseQuestionModel> mapping = {
        for (var group in listQuestions) group.id!: group
      };
      for (var groupId in anamnese.orderOfQuestions) {
        listQuestionsReordened.add(mapping[groupId]!);
      }
    } else {
      listQuestionsReordened = [...listQuestions];
    }
    */
    var listQuestionsReordened = [...listQuestions];
    return listQuestionsReordened;
  }
/*
  void set(List<AnamneseQuestionModel> listReordered) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      var itens = <String>[];
      for (var item in listReordered) {
        itens.add(item.id!);
      }
      var anamnese = await ref
          .read(anamneseRepositoryProvider)
          .readByName('orderOfQuestions');
      anamnese ??= AnamneseModel(name: 'orderOfQuestions');
      await ref
          .read(anamneseRepositoryProvider)
          .save(anamnese.copyWith(orderOfQuestions: itens));
      return listReordered;
    });
  }
  */
}

@riverpod
FutureOr<List<AnamneseGroupModel>> anamneseGroups(AnamneseGroupsRef ref) async {
  QueryBuilder<ParseObject> query2 =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  query2.orderByAscending('name');
  final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
    query2,
    cols: {
      "${AnamneseGroupEntity.className}.cols": [
        AnamneseGroupEntity.name,
        AnamneseGroupEntity.orderOfQuestions,
      ],
    },
  );
  return listGroups;
}

@riverpod
class AnamneseGroupList extends _$AnamneseGroupList {
  @override
  List<AnamneseGroupModel> build() {
    return [];
  }

  void set(List<AnamneseGroupModel> value) {
    state = value;
  }
}

@riverpod
class AnamnesesGroupSelected extends _$AnamnesesGroupSelected {
  @override
  AnamneseGroupModel build() {
    final list = ref.read(anamneseGroupListProvider);
    return list[0];
  }

  void set(AnamneseGroupModel value) {
    state = value;
  }
}
/*
@riverpod
List<AnamneseQuestionModel> questionsFiltered(QuestionsFilteredRef ref) {
  final search = ref.watch(anamnesesGroupSelectedProvider);
  final data = ref.watch(anamneseQuestionsProvider);
  return data.when(
    data: (data) {
      final questionsUnOrdered = data
          .where((element) => element.anamneseGroup.id == search.id)
          .toList();
      var questionsOrdered = <AnamneseQuestionModel>[];
      if (search.orderOfQuestions.isNotEmpty) {
        final Map<String, AnamneseQuestionModel> mapping = {
          for (var question in questionsUnOrdered) question.id!: question
        };
        for (var questionId in search.orderOfQuestions) {
          questionsOrdered.add(mapping[questionId]!);
        }
      } else {
        questionsOrdered = [...questionsUnOrdered];
      }

      return questionsOrdered;
    },
    error: (error, stackTrace) => [],
    loading: () => [],
  );
}
*/

@riverpod
class QuestionsFiltered extends _$QuestionsFiltered {
  @override
  List<AnamneseQuestionModel> build() {
    final search = ref.watch(anamnesesGroupSelectedProvider);
    final data = ref.watch(anamneseQuestionsProvider);
    return data.when(
      data: (data) {
        print('group: $search');
        final questionsUnOrdered = data
            .where((element) => element.anamneseGroup.id == search.id)
            .toList();
        var questionsOrdered = <AnamneseQuestionModel>[];
        if (search.orderOfQuestions.isNotEmpty) {
          final Map<String, AnamneseQuestionModel> mapping = {
            for (var question in questionsUnOrdered) question.id!: question
          };
          for (var questionId in search.orderOfQuestions) {
            questionsOrdered.add(mapping[questionId]!);
          }
        } else {
          questionsOrdered = [...questionsUnOrdered];
        }

        return questionsOrdered;
      },
      error: (error, stackTrace) => [],
      loading: () => [],
    );
  }

  void set(List<AnamneseQuestionModel> listReordered) async {
    var itens = <String>[];
    for (var item in listReordered) {
      itens.add(item.id!);
    }
    final group = ref.watch(anamnesesGroupSelectedProvider);

    await ref
        .read(anamneseGroupRepositoryProvider)
        .save(group.copyWith(orderOfQuestions: itens));
    state = listReordered;
  }
}
