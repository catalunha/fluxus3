import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplantype_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/healthplantype_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<HealthPlanTypeModel>> healthPlanTypeList(
    HealthPlanTypeListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(HealthPlanTypeEntity.className));
  query.orderByAscending('name');
  return await ref.read(healthPlanTypeRepositoryProvider).list(query);
}
