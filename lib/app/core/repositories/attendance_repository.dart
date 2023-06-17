import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/attendance_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/attendance_model.dart';

class AttendanceRepository {
  final AttendanceB4a apiB4a = AttendanceB4a();

  AttendanceRepository();
  Future<List<AttendanceModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);

  Future<AttendanceModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);

  Future<String> update(AttendanceModel model) => apiB4a.update(model);

  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
  Future<bool> confirmPresence(String modelId) =>
      apiB4a.confirmPresence(modelId);
  Future<bool> unConfirmPresence(String modelId) =>
      apiB4a.unConfirmPresence(modelId);
}
