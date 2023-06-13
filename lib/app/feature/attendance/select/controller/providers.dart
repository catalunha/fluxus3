import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<AttendanceModel>> attendanceSelect(
    AttendanceSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(attendanceRepositoryProvider).list(query);
  return list;
}

@riverpod
class AttendanceSelected extends _$AttendanceSelected {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void toggle(AttendanceModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<AttendanceModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
