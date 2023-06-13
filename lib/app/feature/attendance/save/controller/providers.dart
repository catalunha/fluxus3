import 'dart:developer';

import 'package:fluxus3/app/feature/attendance/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/healthplan_model.dart';
import '../../../../core/models/patient_model.dart';
import '../../../../core/models/procedure_model.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AttendanceModel?> attendanceRead(AttendanceReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final attendance =
        await ref.read(attendanceRepositoryProvider).readById(id);
    if (attendance != null) {
      ref.watch(attendanceFormProvider.notifier).setModel(attendance);
      ref
          .watch(authorizationDateCreateProvider.notifier)
          .set(attendance.authorizationDateCreated);
      ref
          .watch(authorizationDateLimitProvider.notifier)
          .set(attendance.authorizationDateLimit);
      ref
          .watch(professionalSelectedProvider.notifier)
          .set(attendance.professional);
      ref
          .watch(proceduresProvider.notifier)
          .set(attendance.procedure != null ? [attendance.procedure!] : []);
      ref.watch(patientSelectedProvider.notifier).set(attendance.patient);
      ref
          .watch(healthPlansProvider.notifier)
          .set(attendance.healthPlan != null ? [attendance.healthPlan!] : []);
      return attendance;
    }
  }
  return null;
}

@riverpod
class AuthorizationDateCreate extends _$AuthorizationDateCreate {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class AuthorizationDateLimit extends _$AuthorizationDateLimit {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class ProfessionalSelected extends _$ProfessionalSelected {
  @override
  UserProfileModel? build() {
    return null;
  }

  void set(UserProfileModel? value) {
    state = value;
    ref.watch(proceduresProvider.notifier).set(state?.procedures ?? []);
  }
}

@riverpod
class Procedures extends _$Procedures {
  @override
  List<ProcedureModel> build() {
    return [];
  }

  void set(List<ProcedureModel> list) {
    state = list;
  }

  void duplicate(String id) async {
    int index = state.indexWhere((value) => value.id == id);
    if (index >= 0) {
      List<ProcedureModel> temp = [...state];
      final model = temp.firstWhere((value) => value.id == id);
      temp.insert(index, model);
      state = [...temp];
    }
  }

  void delete(String id) async {
    int index = state.indexWhere((value) => value.id == id);
    if (index >= 0) {
      List<ProcedureModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    }
  }
}

@riverpod
class PatientSelected extends _$PatientSelected {
  @override
  PatientModel? build() {
    return null;
  }

  void set(PatientModel? value) {
    state = value;
    ref.watch(healthPlansProvider.notifier).set(state?.healthPlans ?? []);
  }
}

@riverpod
class HealthPlans extends _$HealthPlans {
  @override
  List<HealthPlanModel> build() {
    return [];
  }

  void set(List<HealthPlanModel> list) {
    state = list;
  }

  void delete(String id) async {
    int index = state.indexWhere((value) => value.id == id);
    if (index >= 0) {
      List<HealthPlanModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    }
  }
}

@riverpod
class AttendanceForm extends _$AttendanceForm {
  @override
  AttendanceFormState build() {
    return AttendanceFormState();
  }

  void setModel(AttendanceModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String authorizationCode,
    required String description,
  }) async {
    state = state.copyWith(status: AttendanceFormStatus.loading);
    try {
      final authorizationDateCreate = ref.read(authorizationDateCreateProvider);
      final authorizationDateLimit = ref.read(authorizationDateLimitProvider);
      final professional = ref.watch(professionalSelectedProvider);
      final procedures = ref.watch(proceduresProvider);
      final patient = ref.watch(patientSelectedProvider);
      final healthPlans = ref.watch(healthPlansProvider);
      for (var procedure in procedures) {
        final attendanceTemp = AttendanceModel(
          professional: professional,
          procedure: procedure,
          patient: patient,
          healthPlan: healthPlans[0],
          authorizationCode: authorizationCode,
          description: description,
          authorizationDateCreated: authorizationDateCreate,
          authorizationDateLimit: authorizationDateLimit,
        );
        await ref.read(attendanceRepositoryProvider).update(attendanceTemp);
      }
      ref.invalidate(attendanceListProvider);
      state = state.copyWith(status: AttendanceFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AttendanceFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: AttendanceFormStatus.loading);
    try {
      await ref.read(attendanceRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(attendanceListProvider);
      state = state.copyWith(status: AttendanceFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AttendanceFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
