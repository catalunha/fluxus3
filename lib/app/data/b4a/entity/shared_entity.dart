import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/shared_model.dart';
import 'patient_entity.dart';
import 'user_profile_entity.dart';

class SharedEntity {
  static const String className = 'Shared';
  static const String id = 'objectId';
  static const String createdAt = 'createdAt';
  //pointerCols
  static const String professional = 'professional';
  static const String patient = 'patient';
  //singleCols
  static const String description = 'description';
  static const String document = 'document';

  Future<SharedModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    final SharedModel model = SharedModel(
      id: parseObject.objectId!,
      createdAt: parseObject.createdAt!.toLocal(),
      professional: parseObject.get(SharedEntity.professional) != null
          ? await UserProfileEntity()
              .toModel(parseObject.get(SharedEntity.professional))
          : null,
      patient: parseObject.get(SharedEntity.patient) != null
          ? await PatientEntity()
              .toModel(parseObject.get(SharedEntity.patient), cols: cols)
          : null,
      description: parseObject.get(SharedEntity.description),
      document: parseObject.get(SharedEntity.document)?.get('url'),
    );
    return model;
  }

  Future<ParseObject> toParse(SharedModel model) async {
    final parseObject = ParseObject(SharedEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(
        SharedEntity.professional,
        (ParseObject(UserProfileEntity.className)
              ..objectId = model.professional!.id)
            .toPointer());

    parseObject.set(
        SharedEntity.patient,
        (ParseObject(PatientEntity.className)..objectId = model.patient!.id)
            .toPointer());

    parseObject.set(SharedEntity.description, model.description);

    return parseObject;
  }
}
