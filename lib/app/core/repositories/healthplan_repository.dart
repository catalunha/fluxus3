import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/healthplan_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/healthplan_model.dart';

class HealthPlanRepository {
  final HealthPlanB4a apiB4a = HealthPlanB4a();

  HealthPlanRepository();
  Future<List<HealthPlanModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);
  Future<HealthPlanModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);
  Future<String> update(HealthPlanModel model) => apiB4a.update(model);
  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
