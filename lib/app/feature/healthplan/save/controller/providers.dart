import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplan_model.dart';
import '../../../../core/repositories/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<HealthPlanModel?> healthPlanRead(HealthPlanReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final healthPlan =
        await ref.read(healthPlanRepositoryProvider).readById(id);
    if (healthPlan != null) {
      ref.read(healthPlanFormProvider.notifier).setModel(healthPlan);
      return healthPlan;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class HealthPlanForm extends _$HealthPlanForm {
  @override
  HealthPlanFormState build() {
    return HealthPlanFormState();
  }

  void setModel(HealthPlanModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String code}) async {
    state = state.copyWith(status: HealthPlanFormStatus.loading);
    try {
      HealthPlanModel? healthPlanTemp;
      if (state.model != null) {
        healthPlanTemp = state.model!.copyWith(code: code);
      } else {
        healthPlanTemp = HealthPlanModel(code: code);
      }
      final id =
          await ref.read(healthPlanRepositoryProvider).update(healthPlanTemp);
      healthPlanTemp = healthPlanTemp.copyWith(id: id);
      // ref.invalidate(healthPlanListProvider);
      state = state.copyWith(
          status: HealthPlanFormStatus.success, model: healthPlanTemp);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: HealthPlanFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: HealthPlanFormStatus.loading);
    try {
      await ref.read(healthPlanRepositoryProvider).delete(state.model!.id!);
      // ref.invalidate(healthPlanListProvider);
      state = state.copyWith(status: HealthPlanFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: HealthPlanFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
