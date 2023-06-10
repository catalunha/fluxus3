import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/expertise_model.dart';
import '../../../../data/b4a/entity/expertise_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<ExpertiseModel>> expertiseSelect(ExpertiseSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(expertiseRepositoryProvider).list(query);
  return list;
}

@riverpod
class ExpertiseSelected extends _$ExpertiseSelected {
  @override
  List<ExpertiseModel> build() {
    return [];
  }

  void toggle(ExpertiseModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<ExpertiseModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
