import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/shared_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/shared_model.dart';

class SharedRepository {
  final SharedB4a apiB4a = SharedB4a();

  SharedRepository();
  Future<List<SharedModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);

  Future<SharedModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);

  Future<String> update(SharedModel model) => apiB4a.update(model);

  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
