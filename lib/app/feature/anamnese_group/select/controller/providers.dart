import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_group_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<AnamneseGroupModel>> anamneseGroupSelect(
    AnamneseGroupSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
  query.orderByAscending('name');
  final list = await ref.read(anamneseGroupRepositoryProvider).list(query);
  return list;
}

@riverpod
class AnamneseGroupSelected extends _$AnamneseGroupSelected {
  @override
  List<AnamneseGroupModel> build() {
    return [];
  }

  void toggle(AnamneseGroupModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<AnamneseGroupModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
