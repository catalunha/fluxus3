import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/procedure_model.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<ProcedureModel>> procedureList(ProcedureListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
  query.orderByAscending('name');
  return await ref.read(procedureRepositoryProvider).list(query);
}
