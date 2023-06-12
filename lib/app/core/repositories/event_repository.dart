import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/event_b4a.dart';
import '../models/event_model.dart';
import '../../data/utils/pagination.dart';

class EventRepository {
  final EventB4a apiB4a = EventB4a();

  EventRepository();
  Future<List<EventModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.list(query, pagination: pagination, cols: cols);

  Future<String> update(EventModel userProfileModel) =>
      apiB4a.update(userProfileModel);

  Future<EventModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      apiB4a.readById(id, cols: cols);

  Future<void> updateRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) =>
      apiB4a.updateRelation(
          objectId: objectId,
          relationColumn: relationColumn,
          relationTable: relationTable,
          ids: ids,
          add: add);
}
