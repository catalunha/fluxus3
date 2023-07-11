import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<AttendanceModel>> attendanceSelect(
    AttendanceSelectRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  query.orderByDescending(AttendanceEntity.updatedAt);
  final list = await ref.read(attendanceRepositoryProvider).list(query);
  ref.watch(attendanceListDataProvider.notifier).set(list);

  return list;
}

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

@riverpod
class AttendanceSelected extends _$AttendanceSelected {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void toggle(AttendanceModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<AttendanceModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
