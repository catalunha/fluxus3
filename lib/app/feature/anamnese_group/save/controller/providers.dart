import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/models/anamnese_model.dart';
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
      final newAnamneseGroupId = await ref
          .read(anamneseGroupRepositoryProvider)
          .save(anamneseGrouptemp);
      var anamnese = await ref
          .read(anamneseRepositoryProvider)
          .readByName('orderOfGroups');
      anamnese ??= AnamneseModel(name: 'orderOfGroups');
      if (state.model == null) {
        var listOld = [...anamnese.orderOfGroups];
        listOld.add(newAnamneseGroupId);
        await ref
            .read(anamneseRepositoryProvider)
            .save(anamnese.copyWith(orderOfGroups: listOld));
      }

      ref.invalidate(anamneseGroupsProvider);
      state = state.copyWith(status: AnamneseGroupFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseGroupFormStatus.error,
          error: 'Erro em editar Anamnese Group');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: AnamneseGroupFormStatus.loading);
    try {
      final deletedAnamneseGroupId = await ref
          .read(anamneseGroupRepositoryProvider)
          .delete(state.model!.id!);

      var anamnese = await ref
          .read(anamneseRepositoryProvider)
          .readByName('orderOfGroups');
      anamnese ??= AnamneseModel(name: 'orderOfGroups');
      var listOld = [...anamnese.orderOfGroups];
      listOld.remove(deletedAnamneseGroupId);
      await ref
          .read(anamneseRepositoryProvider)
          .save(anamnese.copyWith(orderOfGroups: listOld));

      ref.invalidate(anamneseGroupsProvider);
      state = state.copyWith(status: AnamneseGroupFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseGroupFormStatus.error,
          error: 'Erro em editar Anamnese Group');
    }
  }
}
