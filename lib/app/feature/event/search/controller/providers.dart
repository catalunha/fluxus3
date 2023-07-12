import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/models/patient_model.dart';
import '../../../../core/models/procedure_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import '../../../../data/b4a/entity/event_entity.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';
import '../../../../data/b4a/entity/room_entity.dart';
import '../../../../data/b4a/entity/status_entity.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<EventModel>> eventList(EventListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  if (ref.read(dateSelectProvider)) {
    final start = ref.read(startSearchProvider);
    final end = ref.read(endSearchProvider);
    query.whereGreaterThanOrEqualsTo(
        EventEntity.start, DateTime(start.year, start.month, start.day));
    query.whereLessThanOrEqualTo(
        EventEntity.end, DateTime(end.year, end.month, end.day, 23, 59));
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
    log(ref.read(professionalSelectedProvider)!.id);
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.professional,
        (ParseObject(UserProfileEntity.className)
              ..objectId = ref.read(professionalSelectedProvider)!.id)
            .toPointer());
    if (ref.read(dateSelectProvider)) {
      final start = ref.read(startSearchProvider);
      final end = ref.read(endSearchProvider);
      queryAttendance.whereGreaterThanOrEqualsTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(start.year, start.month, start.day));
      queryAttendance.whereLessThanOrEqualTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(end.year, end.month, end.day, 23, 59));
    }
    final list = await ref.read(attendanceRepositoryProvider).list(
      queryAttendance,
      cols: {
        '${AttendanceEntity.className}.cols': [AttendanceEntity.id]
      },
    );
    // for (var element in list) {
    //   print('${element.id}');
    // }

    List<QueryBuilder<ParseObject>> listQueries = [];
    for (var element in list) {
      final QueryBuilder<ParseObject> queryTemp =
          QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
      queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer(),
      );

      listQueries.add(queryTemp);
    }
    query = QueryBuilder.or(
      ParseObject(EventEntity.className),
      listQueries,
    );

    // if (ref.read(dateSelectProvider)) {
    //   final start = ref.read(startSearchProvider);
    //   final end = ref.read(endSearchProvider);
    //   query.whereGreaterThanOrEqualsTo(
    //       EventEntity.day, DateTime(start.year, start.month, start.day));
    //   query.whereLessThanOrEqualTo(
    //       EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
    // }
  }
  // if (ref.read(procedureSelectProvider)) {
  //   final QueryBuilder<ParseObject> queryAttendance =
  //       QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  //   queryAttendance.whereEqualTo(
  //       AttendanceEntity.procedure,
  //       (ParseObject(ProcedureEntity.className)
  //             ..objectId = ref.read(procedureSelectedProvider)!.id)
  //           .toPointer());

  //   query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
  // }
  if (ref.read(procedureSelectProvider)) {
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.procedure,
        (ParseObject(ProcedureEntity.className)
              ..objectId = ref.read(procedureSelectedProvider)!.id)
            .toPointer());

    if (ref.read(dateSelectProvider)) {
      final start = ref.read(startSearchProvider);
      final end = ref.read(endSearchProvider);
      queryAttendance.whereGreaterThanOrEqualsTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(start.year, start.month, start.day));
      queryAttendance.whereLessThanOrEqualTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(end.year, end.month, end.day, 23, 59));
    }
    final list = await ref.read(attendanceRepositoryProvider).list(
      queryAttendance,
      cols: {
        '${AttendanceEntity.className}.cols': [AttendanceEntity.id]
      },
    );
    log('+++Attendance para Procedure : ${ref.read(procedureSelectedProvider)!.id}');
    var index = 1;

    for (var element in list) {
      log('${index++}: ${element.id}');
    }
    log('---Attendance para Procedure : ${ref.read(procedureSelectedProvider)!.id}');

    List<QueryBuilder<ParseObject>> listQueries = [];
    index = 1;
    for (var element in list) {
      final QueryBuilder<ParseObject> queryTemp =
          QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
      queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer(),
      );
      if (index > 60) {
        break;
      } else {
        index++;
      }
      listQueries.add(queryTemp);
    }
    query = QueryBuilder.or(
      ParseObject(EventEntity.className),
      listQueries,
    );

    // if (ref.read(dateSelectProvider)) {
    //   final start = ref.read(startSearchProvider);
    //   final end = ref.read(endSearchProvider);
    //   query.whereGreaterThanOrEqualsTo(
    //       EventEntity.day, DateTime(start.year, start.month, start.day));
    //   query.whereLessThanOrEqualTo(
    //       EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
    // }
  }

  // if (ref.read(patientSelectProvider)) {
  //   final QueryBuilder<ParseObject> queryAttendance =
  //       QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  //   queryAttendance.whereEqualTo(
  //       AttendanceEntity.patient,
  //       (ParseObject(PatientEntity.className)
  //             ..objectId = ref.read(patientSelectedProvider)!.id)
  //           .toPointer());

  //   query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
  // }
  if (ref.read(patientSelectProvider)) {
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    queryAttendance.whereEqualTo(
        AttendanceEntity.patient,
        (ParseObject(PatientEntity.className)
              ..objectId = ref.read(patientSelectedProvider)!.id)
            .toPointer());
    if (ref.read(dateSelectProvider)) {
      final start = ref.read(startSearchProvider);
      final end = ref.read(endSearchProvider);
      queryAttendance.whereGreaterThanOrEqualsTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(start.year, start.month, start.day));
      queryAttendance.whereLessThanOrEqualTo(
          AttendanceEntity.authorizationDateCreated,
          DateTime(end.year, end.month, end.day, 23, 59));
    }
    final list = await ref.read(attendanceRepositoryProvider).list(
      queryAttendance,
      cols: {
        '${AttendanceEntity.className}.cols': [AttendanceEntity.id]
      },
    );
    log('+++Atendimento para o patient: ${ref.read(patientSelectedProvider)!.id}');
    for (var element in list) {
      log('${element.id}');
    }
    log('---Atendimento para o patient: ${ref.read(patientSelectedProvider)!.id}');

    List<QueryBuilder<ParseObject>> listQueries = [];
    for (var element in list) {
      final QueryBuilder<ParseObject> queryTemp =
          QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
      queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer(),
      );

      listQueries.add(queryTemp);
    }
    query = QueryBuilder.or(
      ParseObject(EventEntity.className),
      listQueries,
    );

    // if (ref.read(dateSelectProvider)) {
    //   final start = ref.read(startSearchProvider);
    //   final end = ref.read(endSearchProvider);
    //   query.whereGreaterThanOrEqualsTo(
    //       EventEntity.day, DateTime(start.year, start.month, start.day));
    //   query.whereLessThanOrEqualTo(
    //       EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
    // }
  }

  query.orderByAscending(EventEntity.start); //out of issue 21
  return await ref.read(eventRepositoryProvider).list(query, cols: {
    '${EventEntity.className}.cols': [
      EventEntity.start,
      EventEntity.end,
      EventEntity.room,
      EventEntity.status,
      EventEntity.attendances,
    ],
    '${EventEntity.className}.pointers': [
      EventEntity.room,
      EventEntity.status,
    ]
  });
}

@riverpod
class DateSelect extends _$DateSelect {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
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
