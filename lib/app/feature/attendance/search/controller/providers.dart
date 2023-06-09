import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import '../../../../data/b4a/entity/status_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<AttendanceModel>> attendanceList(AttendanceListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));

  // if (ref.read(authorizationCodeSelectProvider)) {
  //   query.whereEqualTo(AttendanceEntity.authorizationCode,
  //       ref.read(authorizationCodeSelectedProvider));
  // }
  // if (ref.read(attendanceIdCodeSelectProvider)) {
  //   query.whereEqualTo(
  //       AttendanceEntity.id, ref.read(attendanceIdCodeSelectedProvider));
  // }
  if (ref.read(statusSelectProvider)) {
    query.whereEqualTo(
        AttendanceEntity.status,
        (ParseObject(StatusEntity.className)
              ..objectId = ref.read(statusSelectedProvider)!.id)
            .toPointer());
  }
  // if (ref.read(professionalSelectProvider)) {
  //   query.whereEqualTo(
  //       AttendanceEntity.professional,
  //       (ParseObject(UserProfileEntity.className)
  //             ..objectId = ref.read(professionalSelectedProvider)!.id)
  //           .toPointer());
  // }
  // if (ref.read(procedureSelectProvider)) {
  //   query.whereEqualTo(
  //       AttendanceEntity.procedure,
  //       (ParseObject(ProcedureEntity.className)
  //             ..objectId = ref.read(procedureSelectedProvider)!.id)
  //           .toPointer());
  // }
  // if (ref.read(patientSelectProvider)) {
  //   query.whereEqualTo(
  //       AttendanceEntity.patient,
  //       (ParseObject(PatientEntity.className)
  //             ..objectId = ref.read(patientSelectedProvider)!.id)
  //           .toPointer());
  // }
  if (ref.read(dateSelectProvider)) {
    final start = ref.read(startSearchProvider);
    final end = ref.read(endSearchProvider);
    query.whereGreaterThanOrEqualsTo(AttendanceEntity.authorizationDateCreated,
        DateTime(start.year, start.month, start.day));
    query.whereLessThanOrEqualTo(AttendanceEntity.authorizationDateCreated,
        DateTime(end.year, end.month, end.day, 23, 59));
  }
  query.orderByDescending('updatedAt');
  final list = await ref.read(attendanceRepositoryProvider).list(
        query,
      );
  ref.watch(attendanceListDataProvider.notifier).set(list);

  return list;
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

// @riverpod
// class AuthorizationCodeSelect extends _$AuthorizationCodeSelect {
//   @override
//   bool build() {
//     return false;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }

// @riverpod
// class AuthorizationCodeSelected extends _$AuthorizationCodeSelected {
//   @override
//   String? build() {
//     return null;
//   }

//   void set(String? value) {
//     state = value;
//   }
// }

// @riverpod
// class AttendanceIdCodeSelect extends _$AttendanceIdCodeSelect {
//   @override
//   bool build() {
//     return false;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }

// @riverpod
// class AttendanceIdCodeSelected extends _$AttendanceIdCodeSelected {
//   @override
//   String? build() {
//     return null;
//   }

//   void set(String? value) {
//     state = value;
//   }
// }

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

// @riverpod
// class ProfessionalSelect extends _$ProfessionalSelect {
//   @override
//   bool build() {
//     return false;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }

// @riverpod
// class ProfessionalSelected extends _$ProfessionalSelected {
//   @override
//   UserProfileModel? build() {
//     return null;
//   }

//   void set(UserProfileModel? value) {
//     state = value;
//   }
// }

// @riverpod
// class ProcedureSelect extends _$ProcedureSelect {
//   @override
//   bool build() {
//     return false;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }

// @riverpod
// class ProcedureSelected extends _$ProcedureSelected {
//   @override
//   ProcedureModel? build() {
//     return null;
//   }

//   void set(ProcedureModel? value) {
//     state = value;
//   }
// }

// @riverpod
// class PatientSelect extends _$PatientSelect {
//   @override
//   bool build() {
//     return false;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }

// @riverpod
// class PatientSelected extends _$PatientSelected {
//   @override
//   PatientModel? build() {
//     return null;
//   }

//   void set(PatientModel? value) {
//     state = value;
//   }
// }

@Riverpod(keepAlive: true)
class AttendanceListData extends _$AttendanceListData {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void set(List<AttendanceModel> value) {
    state = value;
  }
}

@riverpod
class AttendanceSearch extends _$AttendanceSearch {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@riverpod
class AttendanceColumnSelected extends _$AttendanceColumnSelected {
  @override
  AttendanceColumnBySearch build() {
    return AttendanceColumnBySearch.professional;
  }

  void set(AttendanceColumnBySearch value) {
    state = value;
  }
}

@riverpod
List<AttendanceModel> attendanceFiltered(AttendanceFilteredRef ref) {
  final search = ref.watch(attendanceSearchProvider);
  final List<AttendanceModel> data = ref.watch(attendanceListDataProvider);
  final column = ref.watch(attendanceColumnSelectedProvider);

  return switch (column) {
    AttendanceColumnBySearch.patient => data
        .where((element) => (element.patient != null &&
            element.patient!.name!.toLowerCase().contains(search)))
        .toList(),
    AttendanceColumnBySearch.authorizationCode => data
        .where((element) => (element.authorizationCode != null &&
            element.authorizationCode!.toLowerCase().contains(search)))
        .toList(),
    AttendanceColumnBySearch.objectId => data
        .where((element) =>
            (element.id != null && element.id!.toLowerCase().contains(search)))
        .toList(),
    _ => data
        .where((element) => (element.professional != null &&
            element.professional!.name!.toLowerCase().contains(search)))
        .toList(),
  };

  // return data
  //     .where((element) => (element.name != null &&
  //         element.name!.toLowerCase().contains(search)))
  //     .toList();
}
