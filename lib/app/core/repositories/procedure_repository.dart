import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/procedure_b4a.dart';
import '../../data/utils/pagination.dart';
import '../models/procedure_model.dart';

class ProcedureRepository {
  final ProcedureB4a apiB4a = ProcedureB4a();

  ProcedureRepository();
  Future<List<ProcedureModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);

  Future<ProcedureModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);

  Future<String> update(ProcedureModel model) => apiB4a.update(model);

  Future<bool> delete(String modelId) => apiB4a.delete(modelId);
}
