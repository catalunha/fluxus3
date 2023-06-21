import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/models/anamnese_question_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AnamneseQuestionModel?> anamneseQuestionRead(
    AnamneseQuestionReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final anamneseQuestion =
        await ref.read(anamneseQuestionRepositoryProvider).readById(id);
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

  void set(AnamneseGroupModel? value) {
    state = value;
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

      late AnamneseQuestionModel anamneseQuestiontemp;
      if (state.model != null) {
        anamneseQuestiontemp = state.model!.copyWith(
          text: text,
          description: description,
          anamneseGroup: group!,
          type: type.name,
          isActive: ref.read(anamneseQuestionIsActiveProvider),
        );
      } else {
        anamneseQuestiontemp = AnamneseQuestionModel(
          text: text,
          description: description,
          anamneseGroup: group!,
          type: type.name,
          isActive: ref.read(anamneseQuestionIsActiveProvider),
        );
      }
      await ref
          .read(anamneseQuestionRepositoryProvider)
          .save(anamneseQuestiontemp);
      ref.invalidate(anamneseQuestionsProvider);
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
      ref.invalidate(anamneseQuestionsProvider);
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
