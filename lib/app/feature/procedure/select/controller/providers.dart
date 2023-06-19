import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/procedure_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<ProcedureModel>> procedureSelect(ProcedureSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(procedureRepositoryProvider).list(query);
  ref.watch(procedureListDataProvider.notifier).set(list);
  return list;
}

@riverpod
class ProcedureSearch extends _$ProcedureSearch {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@riverpod
class ProcedureListData extends _$ProcedureListData {
  @override
  List<ProcedureModel> build() {
    return [];
  }

  void set(List<ProcedureModel> value) {
    state = value;
  }
}

@riverpod
List<ProcedureModel> procedureFiltered(ProcedureFilteredRef ref) {
  // final filterSelected = ref.watch(procedureFilteredByProvider);
  final search = ref.watch(procedureSearchProvider);
  final data = ref.watch(procedureListDataProvider);

  return data
      .where((element) => (element.description != null &&
          element.description!.toLowerCase().contains(search)))
      .toList();
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
