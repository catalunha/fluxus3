import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/region_model.dart';
import '../../../../data/b4a/entity/region_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<RegionModel>> regionList(RegionListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(RegionEntity.className));
  query.orderByDescending('name');
  return await ref.read(regionRepositoryProvider).list(query);
}
