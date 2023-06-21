import 'dart:developer';

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
    log('Rebuilding...', name: 'anamneseQuestionsProvider');
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
    return listQuestions;
  }
}

@riverpod
FutureOr<List<AnamneseGroupModel>> anamneseGroups(AnamneseGroupsRef ref) async {
  log('Rebuilding...', name: 'anamneseGroupsProvider');

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  query.orderByAscending('name');
  final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
    query,
    cols: {
      "${AnamneseGroupEntity.className}.cols": [
        AnamneseGroupEntity.name,
        AnamneseGroupEntity.orderOfQuestions,
      ],
    },
  );
  final groupSelected = ref.read(anamneseGroupSelectedProvider);
  if (groupSelected == null && listGroups.isNotEmpty) {
    ref.read(anamneseGroupSelectedProvider.notifier).set(listGroups.first);
  } else {
    final index =
        listGroups.indexWhere((element) => element.id == groupSelected!.id);
    ref.read(anamneseGroupSelectedProvider.notifier).set(listGroups[index]);
  }

  return listGroups;
}

@riverpod
class AnamneseGroupSelected extends _$AnamneseGroupSelected {
  @override
  AnamneseGroupModel? build() {
    log('Rebuilding...', name: 'anamneseGroupSelectedProvider');

    return null;
  }

  void set(AnamneseGroupModel value) {
    state = value;
  }
}

@riverpod
class QuestionsFiltered extends _$QuestionsFiltered {
  @override
  List<AnamneseQuestionModel> build() {
    log('Rebuilding...', name: 'questionsFilteredProvider');
    final questions = ref.watch(anamneseQuestionsProvider);
    final group = ref.watch(anamneseGroupSelectedProvider);
    ref.watch(anamneseGroupsProvider);
    return questions.when(
      data: (questions) {
        if (questions.isNotEmpty) {
          if (group != null) {
            log('questions.length: ${questions.length}',
                name: 'questionsFilteredProvider');
            log('group: $group', name: 'questionsFilteredProvider');
            final questionsUnOrdered = questions
                .where((element) => element.anamneseGroup.id == group.id)
                .toList();

            var questionsOrdered = <AnamneseQuestionModel>[];
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
              questionsOrdered = [...questionsUnOrdered];
            }

            return questionsOrdered;
          } else {
            return questions;
          }
        } else {
          return [];
        }
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
    final group = ref.watch(anamneseGroupSelectedProvider);
    if (group != null) {
      await ref
          .read(anamneseGroupRepositoryProvider)
          .save(group.copyWith(orderOfQuestions: itens));
    }
    state = listReordered;
  }
}
