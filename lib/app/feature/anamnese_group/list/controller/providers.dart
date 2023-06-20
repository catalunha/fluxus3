import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_group_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<AnamneseGroupModel>> anamneseGroupList(
    AnamneseGroupListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  query.orderByAscending('name');
  return await ref.read(anamneseGroupRepositoryProvider).list(query);
}
