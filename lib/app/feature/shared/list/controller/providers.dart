import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/office_entity.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/shared_model.dart';
import '../../../../data/b4a/entity/shared_entity.dart';
import '../../patient/list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<SharedModel>> sharedList(SharedListRef ref) async {
  // Por padrão a lista é privada ao usuario
  final QueryBuilder<ParseObject> myQuery =
      QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
  final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
  myQuery.whereEqualTo(
      SharedEntity.patient,
      (ParseObject(PatientEntity.className)
            ..objectId = sharedPatientSelected!.id)
          .toPointer());
  final auth = ref.read(authChNotProvider);
  myQuery.whereEqualTo(
      SharedEntity.professional,
      (ParseObject(UserProfileEntity.className)
            ..objectId = auth.user?.userProfile?.id)
          .toPointer());
  QueryBuilder<ParseObject> mainQuery =
      QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
  if (ref.read(sharedListByStatusStateProvider) ==
      SharedListByStatus.byOffice) {
    final auth = ref.read(authChNotProvider);
    final List<QueryBuilder<ParseObject>> querysShared = [];
    // List<String> officeIds = [];
    final officeIds =
        auth.user?.userProfile?.offices?.map((e) => e.id!).toList() ?? [];

    //Lista as minhas infos pub ou priv
    // final QueryBuilder<ParseObject> myQuery =
    //     QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    // myQuery.whereEqualTo(
    //     SharedEntity.patient,
    //     (ParseObject(PatientEntity.className)
    //           ..objectId = sharedPatientSelected.id)
    //         .toPointer());
    // myQuery.whereEqualTo(
    //     SharedEntity.professional,
    //     (ParseObject(UserProfileEntity.className)
    //           ..objectId = auth.user?.userProfile?.id)
    //         .toPointer());

    for (var officeId in officeIds) {
      final QueryBuilder<ParseObject> query =
          QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
      final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
      query.whereEqualTo(
          SharedEntity.patient,
          (ParseObject(PatientEntity.className)
                ..objectId = sharedPatientSelected!.id)
              .toPointer());
      final QueryBuilder<ParseObject> queryUserProfileByOffice =
          QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
      queryUserProfileByOffice.whereEqualTo(
          UserProfileEntity.offices,
          (ParseObject(OfficeEntity.className)..objectId = officeId)
              .toPointer());
      query.whereEqualTo(SharedEntity.isPublic, true);

      query.whereMatchesKeyInQuery(
          SharedEntity.professional, 'objectId', queryUserProfileByOffice);
      querysShared.add(query);
    }
    mainQuery = QueryBuilder.or(
      ParseObject(SharedEntity.className),
      [...querysShared, myQuery],
    );
  } else if (ref.read(sharedListByStatusStateProvider) ==
      SharedListByStatus.public) {
    mainQuery = QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
    mainQuery.whereEqualTo(
        SharedEntity.patient,
        (ParseObject(PatientEntity.className)
              ..objectId = sharedPatientSelected!.id)
            .toPointer());
    mainQuery.whereEqualTo(SharedEntity.isPublic, true);
  } else if (ref.read(sharedListByStatusStateProvider) ==
      SharedListByStatus.admin) {
    mainQuery = QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
    mainQuery.whereEqualTo(
        SharedEntity.patient,
        (ParseObject(PatientEntity.className)
              ..objectId = sharedPatientSelected!.id)
            .toPointer());
  }
  mainQuery.orderByDescending(SharedEntity.createdAt);

  final list = await ref.watch(sharedRepositoryProvider).list(mainQuery, cols: {
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

@Riverpod(keepAlive: true)
class SharedListByStatusState extends _$SharedListByStatusState {
  @override
  SharedListByStatus build() {
    return SharedListByStatus.byOffice;
  }

  void set(SharedListByStatus value) {
    state = value;
  }
}
