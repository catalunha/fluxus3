import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<PatientModel?> patientRead(PatientReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final patient = await ref.read(patientRepositoryProvider).readById(id);
    if (patient != null) {
      ref.watch(patientFormProvider.notifier).setModel(patient);
      ref
          .watch(patientIsActiveProvider.notifier)
          .set(patient.isActive ?? false);
      return patient;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class PatientIsActive extends _$PatientIsActive {
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
class PatientForm extends _$PatientForm {
  @override
  PatientFormState build() {
    return PatientFormState();
  }

  void setModel(PatientModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String name}) async {
    state = state.copyWith(status: PatientFormStatus.loading);
    try {
      PatientModel? patientTemp;
      if (state.model != null) {
        patientTemp = state.model!.copyWith(
          name: name,
          isActive: ref.read(patientIsActiveProvider),
        );
      } else {
        patientTemp = PatientModel(
          name: name,
          isActive: ref.read(patientIsActiveProvider),
        );
      }
      await ref.read(patientRepositoryProvider).update(patientTemp);
      ref.invalidate(patientListProvider);
      state = state.copyWith(status: PatientFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: PatientFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: PatientFormStatus.loading);
    try {
      await ref.read(patientRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(patientListProvider);
      state = state.copyWith(status: PatientFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: PatientFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
