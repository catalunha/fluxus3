import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../data/b4a/entity/event_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<EventModel>> eventList(EventListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.orderByAscending(EventEntity.day);
  return await ref.read(eventRepositoryProvider).list(query);
}
