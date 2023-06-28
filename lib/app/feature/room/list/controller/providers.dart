import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/room_model.dart';
import '../../../../data/b4a/entity/room_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<RoomModel>> roomList(RoomListRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(RoomEntity.className));
  query.orderByAscending('name');
  return await ref.read(roomRepositoryProvider).list(query);
}
