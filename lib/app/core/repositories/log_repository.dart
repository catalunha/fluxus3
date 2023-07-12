import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/log_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/log_model.dart';

class LogRepository {
  final LogB4a apiB4a = LogB4a();

  LogRepository();
  Future<List<LogModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<LogModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  Future<String> save(LogModel model) => apiB4a.save(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
