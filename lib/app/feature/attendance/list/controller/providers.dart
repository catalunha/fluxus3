import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<AttendanceModel>> attendanceList(AttendanceListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  query.orderByAscending('name');
  return await ref.read(attendanceRepositoryProvider).list(
        query,
      );
}
