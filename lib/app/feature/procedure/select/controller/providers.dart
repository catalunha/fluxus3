import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/procedure_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<ProcedureModel>> procedureSelect(ProcedureSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(procedureRepositoryProvider).list(query);
  return list;
}

@riverpod
class ProcedureSelected extends _$ProcedureSelected {
  @override
  List<ProcedureModel> build() {
    return [];
  }

  void toggle(ProcedureModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<ProcedureModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
