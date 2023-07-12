import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/log_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class AttendancePresencForm extends _$AttendancePresencForm {
  @override
  AttendancePresencFormState build() {
    return AttendancePresencFormState();
  }

  void set(List<AttendanceModel> values) {
    state = state.copyWith(all: values);
    final confirmeds = <AttendanceModel>[];

    for (var value in values) {
      if (value.confirmedPresence != null) {
        confirmeds.add(value);
      }
    }
    state = state.copyWith(confirmed: confirmeds);
    log('AttendancePresencForm set ${values.length}');
  }

  bool contains(AttendanceModel value) {
    return state.confirmed.contains(value);
  }

  void add(AttendanceModel value) {
    state = state.copyWith(confirmed: [...state.confirmed, value]);
    log('AttendancePresencForm add ${value.id}');
  }

  void remove(AttendanceModel value) {
    final int index =
        state.confirmed.indexWhere((model) => model.id == value.id);
    if (index >= 0) {
      final temp = [...state.confirmed];
      temp.removeAt(index);
      state = state.copyWith(confirmed: [...temp]);
    }
    log('AttendancePresencForm remove ${value.id}');
  }

  Future<void> confirm() async {
    state = state.copyWith(status: AttendancePresencFormStatus.loading);

    try {
      log('AttendancePresencForm confirm ${state.all.length}');

      for (var attendance in state.all) {
        if (state.confirmed.contains(attendance)) {
          final attendanceTemp = attendance.copyWith(
            status: StatusModel(id: 'RnW37csoJU'),
          );
          //log
          final logRepo = ref.read(logRepositoryProvider);
          final auth = ref.read(authChNotProvider);
          logRepo.save(LogModel(
            userProfile: auth.user!.userProfile!.id,
            table: 'Attendance',
            tableId: attendance.id!,
            action: 'Status: RnW37csoJU - presença confirmada. ',
          ));
          //log

          await ref.read(attendanceRepositoryProvider).update(attendanceTemp);
          await ref
              .read(attendanceRepositoryProvider)
              .confirmPresence(attendance.id!);
        } else {
          //log
          final logRepo = ref.read(logRepositoryProvider);
          final auth = ref.read(authChNotProvider);
          logRepo.save(LogModel(
            userProfile: auth.user!.userProfile!.id,
            table: 'Attendance',
            tableId: attendance.id!,
            action:
                '9WGnM73WBI - Inserido num evento. presença não confirmada. ',
          ));
          //log

          final attendanceTemp = attendance.copyWith(
            status: StatusModel(id: '9WGnM73WBI'),
          );
          await ref.read(attendanceRepositoryProvider).update(attendanceTemp);

          await ref
              .read(attendanceRepositoryProvider)
              .unset(attendance.id!, AttendanceEntity.confirmedPresence);
        }
      }
      ref.invalidate(scheduleProvider);
      state = state.copyWith(status: AttendancePresencFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AttendancePresencFormStatus.error,
          error: 'Erro em atualizar presença');
    }
  }
}

/*

@riverpod
class AttendancesStatusPresence extends _$AttendancesStatusPresence {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void set(List<AttendanceModel> values) {
    state = values;
    for (var value in values) {
      if (value.confirmedPresence != null) {
        ref.read(attendancesWithPresenceConfirmedProvider.notifier).add(value);
      }
    }
  }
}

@riverpod
class AttendancesWithPresenceConfirmed
    extends _$AttendancesWithPresenceConfirmed {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void set(List<AttendanceModel> values) {
    for (var value in values) {
      if (value.confirmedPresence != null) {
        state = [...state, value];
      }
    }
  }

  void add(AttendanceModel value) {
    state = [...state, value];
  }

  void remove(AttendanceModel value) {
    int index = state.indexWhere((model) => model.id == value.id);
    if (index >= 0) {
      List<AttendanceModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    }
  }

  Future<void> confirm() async {
    final all = ref.read(attendancesStatusPresenceProvider);
    for (var attendance in all) {
      if (state.contains(attendance)) {
        if (attendance.confirmedPresence == null) {
          ref
              .read(attendanceRepositoryProvider)
              .confirmPresence(attendance.id!);
        }
      } else {
        if (attendance.confirmedPresence != null) {
          ref
              .read(attendanceRepositoryProvider)
              .unConfirmPresence(attendance.id!);
        }
      }
    }
  }
}
*/