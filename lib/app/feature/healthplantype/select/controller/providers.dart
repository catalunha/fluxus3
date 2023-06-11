import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplantype_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/healthplantype_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<HealthPlanTypeModel>> healthPlanTypeSelect(
    HealthPlanTypeSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(HealthPlanTypeEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(healthPlanTypeRepositoryProvider).list(query);
  return list;
}

@riverpod
class HealthPlanTypeSelected extends _$HealthPlanTypeSelected {
  @override
  List<HealthPlanTypeModel> build() {
    return [];
  }

  void toggle(HealthPlanTypeModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<HealthPlanTypeModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
