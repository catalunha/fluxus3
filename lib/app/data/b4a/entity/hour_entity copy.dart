import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/hour_model.dart';

class HourEntity {
  static const String className = 'Hour';
  static const String id = 'objectId';
  static const String name = 'name';
  static const String start = 'start';
  static const String end = 'end';
  static const String isActive = 'isActive';

  HourModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    HourModel model = HourModel(
      id: parseObject.objectId!,
      name: parseObject.get(HourEntity.name),
      start: parseObject.get<DateTime>(HourEntity.start)?.toLocal(),
      end: parseObject.get<DateTime>(HourEntity.end)?.toLocal(),
      isActive: parseObject.get(HourEntity.isActive),
    );
    return model;
  }

  Future<ParseObject> toParse(HourModel model) async {
    final parseObject = ParseObject(HourEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(HourEntity.name, model.name);
    if (model.start != null) {
      parseObject.set<DateTime?>(HourEntity.start,
          DateTime(model.start!.year, model.start!.month, model.start!.day));
    }
    if (model.end != null) {
      parseObject.set<DateTime?>(HourEntity.end,
          DateTime(model.end!.year, model.end!.month, model.end!.day));
    }
    if (model.isActive != null) {
      parseObject.set(HourEntity.isActive, model.isActive);
    }
    return parseObject;
  }
}
