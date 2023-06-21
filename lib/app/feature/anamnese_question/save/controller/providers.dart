import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/models/anamnese_question_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_group_entity.dart';
import '../../../../data/b4a/entity/anamnese_question_entity.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AnamneseQuestionModel?> anamneseQuestionRead(
    AnamneseQuestionReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final anamneseQuestion =
        await ref.read(anamneseQuestionRepositoryProvider).readById(
      id,
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
    if (anamneseQuestion != null) {
      ref
          .watch(anamneseQuestionFormProvider.notifier)
          .setModel(anamneseQuestion);
      ref
          .watch(anamneseQuestionIsActiveProvider.notifier)
          .set(anamneseQuestion.isActive);
      ref
          .watch(anamneseQuestionIsRequiredProvider.notifier)
          .set(anamneseQuestion.required);
      ref
          .watch(anamneseGroupSelectedProvider.notifier)
          .set(anamneseQuestion.anamneseGroup);
      log('group: ${anamneseQuestion.anamneseGroup}', name: 'Start question');

      final type = switch (anamneseQuestion.type) {
        'boolean' => AnamneseQuestionTypeStatus.boolean,
        'intensity' => AnamneseQuestionTypeStatus.intensity,
        'text' => AnamneseQuestionTypeStatus.text,
        'numerical' => AnamneseQuestionTypeStatus.numerical,
        _ => AnamneseQuestionTypeStatus.boolean,
      };
      ref.watch(anamneseQuestionTypeProvider.notifier).set(type);
      return anamneseQuestion;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class AnamneseQuestionIsActive extends _$AnamneseQuestionIsActive {
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
class AnamneseQuestionIsRequired extends _$AnamneseQuestionIsRequired {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class AnamneseGroupSelected extends _$AnamneseGroupSelected {
  @override
  AnamneseGroupModel? build() {
    return null;
  }

  void set(AnamneseGroupModel? value) async {
    if (value != null && value.orderOfQuestions.isEmpty) {
      final value2 = await ref.read(anamneseGroupRepositoryProvider).readById(
        value.id!,
        cols: {
          "${AnamneseGroupEntity.className}.cols": [
            AnamneseGroupEntity.name,
            AnamneseGroupEntity.orderOfQuestions,
          ],
        },
      );
      state = value2;
    }
    state = value;
    log('state: $state', name: 'Set AnamneseGroupSelected');
  }
}

@riverpod
class AnamneseQuestionType extends _$AnamneseQuestionType {
  @override
  AnamneseQuestionTypeStatus build() {
    return AnamneseQuestionTypeStatus.boolean;
  }

  void set(AnamneseQuestionTypeStatus value) {
    state = value;
  }
}

@riverpod
class AnamneseQuestionForm extends _$AnamneseQuestionForm {
  @override
  AnamneseQuestionFormState build() {
    return AnamneseQuestionFormState();
  }

  void setModel(AnamneseQuestionModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String text,
    String description = '',
  }) async {
    state = state.copyWith(status: AnamneseQuestionFormStatus.loading);
    try {
      final group = ref.read(anamneseGroupSelectedProvider);
      final type = ref.read(anamneseQuestionTypeProvider);
      var groupOld = group!;
      late AnamneseQuestionModel anamneseQuestiontemp;
      if (state.model != null) {
        groupOld = state.model!.anamneseGroup.copyWith();
        anamneseQuestiontemp = state.model!.copyWith(
          text: text,
          description: description,
          anamneseGroup: group,
          type: type.name,
          isActive: ref.read(anamneseQuestionIsActiveProvider),
        );
      } else {
        anamneseQuestiontemp = AnamneseQuestionModel(
          text: text,
          description: description,
          anamneseGroup: group,
          type: type.name,
          isActive: ref.read(anamneseQuestionIsActiveProvider),
        );
      }
      final newAnamneseQuestionId = await ref
          .read(anamneseQuestionRepositoryProvider)
          .save(anamneseQuestiontemp);
      log('newAnamneseQuestionId: $newAnamneseQuestionId',
          name: 'Save question');

      //+++ Atualizando lista de questions em grupo
      if (state.model == null) {
        log('group: $group', name: 'Save new question');
        var listOld = [...group.orderOfQuestions];
        listOld.add(newAnamneseQuestionId);
        await ref
            .read(anamneseGroupRepositoryProvider)
            .save(group.copyWith(orderOfQuestions: listOld));
      } else if (groupOld.id != group.id) {
        log('groupOld: $groupOld', name: 'Save old question');
        log('group: $group', name: 'Save old question');
        //remove do model
        var listOld = [...groupOld.orderOfQuestions];
        listOld.remove(newAnamneseQuestionId);
        await ref
            .read(anamneseGroupRepositoryProvider)
            .save(groupOld.copyWith(orderOfQuestions: listOld));
        // add no group
        listOld.clear();
        listOld = [...group.orderOfQuestions];
        if (!listOld.contains(newAnamneseQuestionId)) {
          listOld.add(newAnamneseQuestionId);
          await ref
              .read(anamneseGroupRepositoryProvider)
              .save(group.copyWith(orderOfQuestions: listOld));
        }
      }
      //---

      ref.invalidate(anamneseGroupsProvider);
      ref.invalidate(anamneseQuestionsProvider);
      // ref.invalidate(questionsFilteredProvider);

      state = state.copyWith(status: AnamneseQuestionFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseQuestionFormStatus.error,
          error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: AnamneseQuestionFormStatus.loading);
    try {
      await ref
          .read(anamneseQuestionRepositoryProvider)
          .delete(state.model!.id!);
      //+++ Atualizando lista de questions em grupo
      final group = ref.read(anamneseGroupSelectedProvider);
      var listOld = [...group!.orderOfQuestions];
      listOld.remove(state.model!.id!);
      await ref
          .read(anamneseGroupRepositoryProvider)
          .save(group.copyWith(orderOfQuestions: listOld));
      //---
      ref.invalidate(anamneseGroupsProvider);
      ref.invalidate(anamneseQuestionsProvider);
      // ref.invalidate(questionsFilteredProvider);
      state = state.copyWith(status: AnamneseQuestionFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseQuestionFormStatus.error,
          error: 'Erro em editar cargo');
    }
  }
}
