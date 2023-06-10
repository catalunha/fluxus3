import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/region_model.dart';
import '../../../../data/b4a/entity/region_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<RegionModel>> regionSelect(RegionSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(RegionEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(regionRepositoryProvider).list(query);
  return list;
}

@riverpod
class RegionSelected extends _$RegionSelected {
  @override
  List<RegionModel> build() {
    return [];
  }

  void toggle(RegionModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<RegionModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
