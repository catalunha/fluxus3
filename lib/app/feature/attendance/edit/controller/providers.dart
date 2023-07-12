import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/log_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../search/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AttendanceModel?> attendanceRead(AttendanceReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final attendance =
        await ref.read(attendanceRepositoryProvider).readById(id);
    if (attendance != null) {
      ref.watch(attendanceFormProvider.notifier).setModel(attendance);
      ref.watch(statusSelectedProvider.notifier).set(attendance.status);
      ref
          .watch(authorizationDateCreateProvider.notifier)
          .set(attendance.authorizationDateCreated ?? DateTime.now());
      ref.watch(authorizationDateLimitProvider.notifier).set(
          attendance.authorizationDateLimit ??
              DateTime.now().add(const Duration(days: 30)));

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
class StatusSelected extends _$StatusSelected {
  @override
  StatusModel? build() {
    return null;
  }

  void set(StatusModel? value) {
    state = value;
  }
}

@riverpod
class AttendanceForm extends _$AttendanceForm {
  @override
  AttendanceFormState build() {
    return AttendanceFormState();
  }

  void setModel(AttendanceModel model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String authorizationCode,
    required String history,
  }) async {
    state = state.copyWith(status: AttendanceFormStatus.loading);
    try {
      final authorizationDateCreate = ref.read(authorizationDateCreateProvider);
      final authorizationDateLimit = ref.read(authorizationDateLimitProvider);
      final status = ref.read(statusSelectedProvider);

      final attendanceTemp = state.model!.copyWith(
        authorizationCode: authorizationCode,
        authorizationDateCreated: authorizationDateCreate,
        authorizationDateLimit: authorizationDateLimit,
        status: status,
      );
      _savingLog('${attendanceTemp.toString()} | $history');

      await ref.read(attendanceRepositoryProvider).update(attendanceTemp);
      ref.invalidate(attendanceListProvider);
      state = state.copyWith(status: AttendanceFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AttendanceFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  void _savingLog(String action) {
    //Salvando dados em log
    final logRepo = ref.read(logRepositoryProvider);
    final auth = ref.read(authChNotProvider);
    logRepo.save(LogModel(
      userProfile: auth.user!.userProfile!.id,
      table: 'Attendance',
      tableId: state.model != null ? state.model!.id! : 'new',
      action: action,
    ));
  }

  Future<void> delete() async {
    state = state.copyWith(status: AttendanceFormStatus.loading);
    try {
      // await ref.read(attendanceRepositoryProvider).delete(state.model!.id!);
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
