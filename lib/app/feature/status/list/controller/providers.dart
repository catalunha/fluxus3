import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/status_model.dart';
import '../../../../data/b4a/entity/status_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<StatusModel>> statusList(StatusListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(StatusEntity.className));
  query.orderByAscending('name');
  return await ref.read(statusRepositoryProvider).list(query);
}
