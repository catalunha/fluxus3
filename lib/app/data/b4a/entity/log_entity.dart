import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/log_model.dart';

class LogEntity {
  static const String className = 'Log';
  static const String id = 'objectId';
  static const String userProfile = 'userProfile';
  static const String table = 'table';
  static const String tableId = 'tableId';
  static const String action = 'action';

  LogModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final LogModel model = LogModel(
      id: parseObject.objectId!,
      userProfile: parseObject.get(LogEntity.userProfile),
      table: parseObject.get(LogEntity.table),
      tableId: parseObject.get(LogEntity.tableId),
      action: parseObject.get(LogEntity.action),
    );
    return model;
  }

  Future<ParseObject> toParse(LogModel model) async {
    final parseObject = ParseObject(LogEntity.className);
    parseObject.objectId = model.id;
    parseObject.set(LogEntity.userProfile, model.userProfile);
    parseObject.set(LogEntity.table, model.table);
    parseObject.set(LogEntity.tableId, model.tableId);
    parseObject.set(LogEntity.action, model.action);
    return parseObject;
  }
}
