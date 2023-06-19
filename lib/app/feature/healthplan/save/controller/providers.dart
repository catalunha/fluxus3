import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplan_model.dart';
import '../../../../core/models/healthplantype_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/healthplan_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<HealthPlanModel?> healthPlanRead(HealthPlanReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final healthPlan = await ref.read(healthPlanRepositoryProvider).readById(
      id,
      cols: {
        "${HealthPlanEntity.className}.cols": [
          HealthPlanEntity.code,
          HealthPlanEntity.description,
          HealthPlanEntity.healthPlanType,
        ],
        "${HealthPlanEntity.className}.pointers": [
          HealthPlanEntity.healthPlanType,
        ],
      },
    );
    if (healthPlan != null) {
      ref.read(healthPlanFormProvider.notifier).setModel(healthPlan);
      ref
          .read(healthPlanTypeSelectedProvider.notifier)
          .set(healthPlan.healthPlanType);

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
class HealthPlanTypeSelected extends _$HealthPlanTypeSelected {
  @override
  HealthPlanTypeModel? build() {
    return null;
  }

  void set(HealthPlanTypeModel? value) {
    state = value;
  }
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

  Future<void> submitForm({
    required String code,
    required String description,
  }) async {
    state = state.copyWith(status: HealthPlanFormStatus.loading);
    try {
      HealthPlanModel? healthPlanTemp;
      if (state.model != null) {
        healthPlanTemp = state.model!.copyWith(
          code: code,
          description: description,
          healthPlanType: ref.read(healthPlanTypeSelectedProvider),
        );
      } else {
        healthPlanTemp = HealthPlanModel(
          code: code,
          description: description,
          healthPlanType: ref.read(healthPlanTypeSelectedProvider),
        );
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
