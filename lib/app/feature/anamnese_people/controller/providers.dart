import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_people_model.dart';
import '../../../data/b4a/entity/anamnese_people_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<AnamnesePeopleModel>> anamnesePeopleList(
    AnamnesePeopleListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamnesePeopleEntity.className));
  query.orderByAscending('name');
  final list =
      await ref.watch(anamnesePeopleRepositoryProvider).list(query, cols: {
    "${AnamnesePeopleEntity.className}.cols": [
      AnamnesePeopleEntity.createdAt,
      AnamnesePeopleEntity.adultName,
      AnamnesePeopleEntity.adultPhone,
      AnamnesePeopleEntity.childName,
      AnamnesePeopleEntity.childIsFemale,
      AnamnesePeopleEntity.childBirthDate,
    ],
  });
  return list;
}
