import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/expertise_model.dart';
import '../../../../data/b4a/entity/expertise_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<ExpertiseModel>> expertiseList(ExpertiseListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
  query.orderByAscending('name');
  return await ref.read(expertiseRepositoryProvider).list(query);
}
