import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AnamneseGroupModel?> anamneseGroupRead(AnamneseGroupReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final anamneseGroup =
        await ref.read(anamneseGroupRepositoryProvider).readById(id);
    if (anamneseGroup != null) {
      ref.watch(anamneseGroupFormProvider.notifier).setModel(anamneseGroup);
      ref
          .watch(anamneseGroupIsActiveProvider.notifier)
          .set(anamneseGroup.isActive);
      return anamneseGroup;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class AnamneseGroupIsActive extends _$AnamneseGroupIsActive {
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
class AnamneseGroupForm extends _$AnamneseGroupForm {
  @override
  AnamneseGroupFormState build() {
    return AnamneseGroupFormState();
  }

  void setModel(AnamneseGroupModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    String description = '',
  }) async {
    state = state.copyWith(status: AnamneseGroupFormStatus.loading);
    try {
      late AnamneseGroupModel anamneseGrouptemp;
      if (state.model != null) {
        anamneseGrouptemp = state.model!.copyWith(
          name: name,
          description: description,
          isActive: ref.read(anamneseGroupIsActiveProvider),
        );
      } else {
        anamneseGrouptemp = AnamneseGroupModel(
          name: name,
          description: description,
          isActive: ref.read(anamneseGroupIsActiveProvider),
        );
      }
      await ref.read(anamneseGroupRepositoryProvider).save(anamneseGrouptemp);
      ref.invalidate(anamneseGroupListProvider);
      state = state.copyWith(status: AnamneseGroupFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseGroupFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: AnamneseGroupFormStatus.loading);
    try {
      await ref.read(anamneseGroupRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(anamneseGroupListProvider);
      state = state.copyWith(status: AnamneseGroupFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseGroupFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
