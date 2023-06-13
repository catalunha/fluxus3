import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/room_model.dart';
import '../../../../data/b4a/entity/room_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<RoomModel>> roomSelect(RoomSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(RoomEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(roomRepositoryProvider).list(query);
  return list;
}

@riverpod
class RoomSelected extends _$RoomSelected {
  @override
  List<RoomModel> build() {
    return [];
  }

  void toggle(RoomModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<RoomModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
