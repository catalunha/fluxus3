import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/room_model.dart';
import '../../../../data/b4a/entity/room_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<RoomModel>> roomSelect(RoomSelectRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(RoomEntity.className));
  query.orderByAscending('name');
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
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<RoomModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
