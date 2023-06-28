import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:fluxus3/app/feature/shared/patient/list/controller/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/shared_model.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../../../data/b4a/entity/shared_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<SharedModel>> sharedList(SharedListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
  final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
  query.whereEqualTo(
      SharedEntity.patient,
      (ParseObject(PatientEntity.className)
            ..objectId = sharedPatientSelected!.id)
          .toPointer());
  query.orderByDescending(SharedEntity.createdAt);
  final list = await ref.watch(sharedRepositoryProvider).list(query, cols: {
    "${SharedEntity.className}.cols": [
      SharedEntity.professional,
      SharedEntity.patient,
      SharedEntity.description,
      SharedEntity.document,
    ],
    "${SharedEntity.className}.pointers": [
      SharedEntity.professional,
      SharedEntity.patient,
    ],
  });
  return list;
}
