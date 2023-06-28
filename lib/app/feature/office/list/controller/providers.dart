import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/office_model.dart';
import '../../../../data/b4a/entity/office_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<OfficeModel>> officeList(OfficeListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(OfficeEntity.className));
  query.orderByDescending('name');
  return await ref.read(officeRepositoryProvider).list(query);
}
