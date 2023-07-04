import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/models/hour_model.dart';
import '../../../../core/models/patient_model.dart';
import '../../../../core/models/procedure_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import '../../../../data/b4a/entity/event_entity.dart';
import '../../../../data/b4a/entity/hour_entity.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';
import '../../../../data/b4a/entity/room_entity.dart';
import '../../../../data/b4a/entity/status_entity.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<EventModel>> eventList(EventListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final start = ref.read(startSearchProvider);
  final end = ref.read(endSearchProvider);
  query.whereGreaterThanOrEqualsTo(
      EventEntity.day, DateTime(start.year, start.month, start.day));
  query.whereLessThanOrEqualTo(
      EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
  if (ref.read(hourSelectProvider)) {
    query.whereEqualTo(
        EventEntity.hour,
        (ParseObject(HourEntity.className)
              ..objectId = ref.read(hourSelectedProvider)!.id)
            .toPointer());
  }
  if (ref.read(roomSelectProvider)) {
    query.whereEqualTo(
        EventEntity.room,
        (ParseObject(RoomEntity.className)
              ..objectId = ref.read(roomSelectedProvider)!.id)
            .toPointer());
  }
  if (ref.read(statusSelectProvider)) {
    query.whereEqualTo(
        EventEntity.status,
        (ParseObject(StatusEntity.className)
              ..objectId = ref.read(statusSelectedProvider)!.id)
            .toPointer());
  }
  if (ref.read(professionalSelectProvider)) {
    // log('ref.read(professionalSelectedProvider)!.id: ${ref.read(professionalSelectedProvider)!.id}');
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.professional,
        (ParseObject(UserProfileEntity.className)
              ..objectId = ref.read(professionalSelectedProvider)!.id)
            .toPointer());
    // query.whereMatchesKeyInQuery(
    //     EventEntity.attendances, 'objectId', queryAttendance);
    query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
  }
  if (ref.read(procedureSelectProvider)) {
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.procedure,
        (ParseObject(ProcedureEntity.className)
              ..objectId = ref.read(procedureSelectedProvider)!.id)
            .toPointer());

    query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
  }
  if (ref.read(patientSelectProvider)) {
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.patient,
        (ParseObject(PatientEntity.className)
              ..objectId = ref.read(patientSelectedProvider)!.id)
            .toPointer());

    query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
  }

  query.orderByDescending('updatedAt');
  return await ref.read(eventRepositoryProvider).list(query, cols: {
    '${EventEntity.className}.cols': [
      EventEntity.day,
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
      EventEntity.attendances,
      EventEntity.history,
    ],
    '${EventEntity.className}.pointers': [
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
    ]
  });
}

@riverpod
class StartSearch extends _$StartSearch {
  @override
  DateTime build() {
    return DateTime.now().subtract(const Duration(days: 7));
  }

  void set(DateTime value) {
    state = value;
  }
}

@riverpod
class EndSearch extends _$EndSearch {
  @override
  DateTime build() {
    return DateTime.now().add(const Duration(days: 15));
  }

  void set(DateTime value) {
    state = value;
  }
}

@riverpod
class HourSelect extends _$HourSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class HourSelected extends _$HourSelected {
  @override
  HourModel? build() {
    return null;
  }

  void set(HourModel? value) {
    state = value;
  }
}

@riverpod
class RoomSelect extends _$RoomSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class RoomSelected extends _$RoomSelected {
  @override
  RoomModel? build() {
    return null;
  }

  void set(RoomModel? value) {
    state = value;
  }
}

@riverpod
class StatusSelect extends _$StatusSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
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
class ProfessionalSelect extends _$ProfessionalSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
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
  }
}

@riverpod
class ProcedureSelect extends _$ProcedureSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class ProcedureSelected extends _$ProcedureSelected {
  @override
  ProcedureModel? build() {
    return null;
  }

  void set(ProcedureModel? value) {
    state = value;
  }
}

@riverpod
class PatientSelect extends _$PatientSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
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
  }
}
