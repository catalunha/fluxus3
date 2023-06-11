import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplantype_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<HealthPlanTypeModel?> healthPlanTypeRead(HealthPlanTypeReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final healthPlanType =
        await ref.read(healthPlanTypeRepositoryProvider).readById(id);
    if (healthPlanType != null) {
      ref.watch(healthPlanTypeFormProvider.notifier).setModel(healthPlanType);
      return healthPlanType;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class HealthPlanTypeForm extends _$HealthPlanTypeForm {
  @override
  HealthPlanTypeFormState build() {
    return HealthPlanTypeFormState();
  }

  void setModel(HealthPlanTypeModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String name}) async {
    state = state.copyWith(
        healthPlanType: HealthPlanTypeFormHealthPlanType.loading);
    try {
      HealthPlanTypeModel? healthPlanTypeTemp;
      if (state.model != null) {
        healthPlanTypeTemp = state.model!.copyWith(
          name: name,
        );
      } else {
        healthPlanTypeTemp = HealthPlanTypeModel(
          name: name,
        );
      }
      await ref
          .read(healthPlanTypeRepositoryProvider)
          .update(healthPlanTypeTemp);
      ref.invalidate(healthPlanTypeListProvider);
      state = state.copyWith(
          healthPlanType: HealthPlanTypeFormHealthPlanType.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          healthPlanType: HealthPlanTypeFormHealthPlanType.error,
          error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(
        healthPlanType: HealthPlanTypeFormHealthPlanType.loading);
    try {
      await ref.read(healthPlanTypeRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(healthPlanTypeListProvider);
      state = state.copyWith(
          healthPlanType: HealthPlanTypeFormHealthPlanType.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          healthPlanType: HealthPlanTypeFormHealthPlanType.error,
          error: 'Erro em editar cargo');
    }
  }
}
