import '../../../../core/repositories/providers.dart';
import '../../patient/list/controller/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/shared_model.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../../../data/b4a/entity/shared_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<SharedModel>> sharedList(SharedListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
  final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
  query.whereEqualTo(
      SharedEntity.patient,
      (ParseObject(PatientEntity.className)
            ..objectId = sharedPatientSelected!.id)
          .toPointer());
  // query.whereEqualTo(
  //     'professional.expertises',
  //     (ParseObject(ExpertiseEntity.className)..objectId = 'AwfAwREwOR')
  //         .toPointer());
  // final QueryBuilder<ParseObject> queryUser =
  //     QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
  // queryUser.whereEqualTo(
  //     UserProfileEntity.expertises,
  //     (ParseObject(ExpertiseEntity.className)..objectId = 'AwfAwREwOR')
  //         .toPointer());

  // query.whereMatchesQuery(SharedEntity.professional, queryUser);

  query.orderByDescending(SharedEntity.createdAt);
  final list = await ref.watch(sharedRepositoryProvider).list(query, cols: {
    '${SharedEntity.className}.cols': [
      SharedEntity.professional,
      SharedEntity.patient,
      SharedEntity.description,
      SharedEntity.document,
      SharedEntity.isPublic,
    ],
    '${SharedEntity.className}.pointers': [
      SharedEntity.professional,
      SharedEntity.patient,
    ],
  });
  return list;
}
