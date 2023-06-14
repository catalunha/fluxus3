import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../data/b4a/entity/event_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<EventModel>> eventList(EventListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.orderByAscending(EventEntity.day);
  return await ref.read(eventRepositoryProvider).list(query, cols: {
    "${EventEntity.className}.cols": [
      EventEntity.day,
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
      EventEntity.attendances,
      EventEntity.history,
    ],
    "${EventEntity.className}.pointers": [
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
    ]
  });
}
