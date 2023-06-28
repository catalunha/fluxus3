import 'dart:developer';

import '../../../../core/models/anamnese_group_model.dart';
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
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    query.orderByAscending('text');
    final listQuestions =
        await ref.read(anamneseQuestionRepositoryProvider).list(
      query,
      cols: {
        '${AnamneseQuestionEntity.className}.cols': [
          AnamneseQuestionEntity.text,
          AnamneseQuestionEntity.type,
          AnamneseQuestionEntity.options,
          AnamneseQuestionEntity.isActive,
          AnamneseQuestionEntity.isRequired,
          AnamneseQuestionEntity.group,
        ],
        '${AnamneseQuestionEntity.className}.pointers': [
          AnamneseQuestionEntity.group,
        ],
      },
    );
    return listQuestions;
  }
}

@riverpod
FutureOr<List<AnamneseGroupModel>> anamneseGroups(AnamneseGroupsRef ref) async {
  log('Rebuilding...', name: 'anamneseGroupsProvider');

  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  query.whereEqualTo(AnamneseGroupEntity.isActive, true);
  query.orderByAscending('name');
  final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
    query,
    cols: {
      '${AnamneseGroupEntity.className}.cols': [
        AnamneseGroupEntity.name,
        AnamneseGroupEntity.orderOfQuestions,
      ],
    },
  );

  final anamnese =
      await ref.read(anamneseRepositoryProvider).readByName('orderOfGroups');
  var listGroupsOrdened = <AnamneseGroupModel>[];
  if (anamnese != null && anamnese.orderOfGroups.isNotEmpty) {
    final Map<String, AnamneseGroupModel> mapping = {
      for (var group in listGroups) group.id!: group
    };
    for (var groupId in anamnese.orderOfGroups) {
      if (mapping.containsKey(groupId)) {
        listGroupsOrdened.add(mapping[groupId]!);
      }
    }
  } else {
    listGroupsOrdened = [...listGroups];
  }

  final groupSelected = ref.read(anamneseGroupSelectedProvider);
  if (groupSelected == null && listGroupsOrdened.isNotEmpty) {
    ref
        .read(anamneseGroupSelectedProvider.notifier)
        .set(listGroupsOrdened.first);
  } else {
    final index = listGroupsOrdened
        .indexWhere((element) => element.id == groupSelected!.id);
    ref
        .read(anamneseGroupSelectedProvider.notifier)
        .set(listGroupsOrdened[index]);
  }

  return listGroupsOrdened;
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
                .where((element) => element.group.id == group.id)
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
    final itens = <String>[];
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
