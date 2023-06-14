import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/hour_model.dart';
import '../../../../data/b4a/entity/hour_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<HourModel>> hourSelect(HourSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(HourEntity.className));
  query.orderByAscending('name');
  final list = await ref.read(hourRepositoryProvider).list(query);
  return list;
}

@riverpod
class HourSelected extends _$HourSelected {
  @override
  List<HourModel> build() {
    return [];
  }

  void toggle(HourModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<HourModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
