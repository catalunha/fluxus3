import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/status_model.dart';
import '../../../../data/b4a/entity/status_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<StatusModel>> statusSelect(StatusSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(StatusEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(statusRepositoryProvider).list(query);
  return list;
}

@riverpod
class StatusSelected extends _$StatusSelected {
  @override
  List<StatusModel> build() {
    return [];
  }

  void toggle(StatusModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<StatusModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
