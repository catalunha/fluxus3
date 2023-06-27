import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/procedure_model.dart';
import '../../../../data/b4a/entity/procedure_entity.dart';
import 'states.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<ProcedureModel>> procedureList(ProcedureListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
  query.orderByAscending('name');
  final list = await ref.read(procedureRepositoryProvider).list(query);
  ref.read(procedureListDataProvider.notifier).set(list);
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
class ProcedureFilteredBy extends _$ProcedureFilteredBy {
  @override
  ProcedureFilterBy build() {
    return ProcedureFilterBy.name;
  }

  void set(ProcedureFilterBy value) {
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
  final filterSelected = ref.watch(procedureFilteredByProvider);
  final search = ref.watch(procedureSearchProvider);
  final data = ref.watch(procedureListDataProvider);
/*
  return switch (filterSelected) {
    ProcedureFilterBy.code => data
        .where((element) => (element.description != null &&
            element.code!.toLowerCase().contains(search)))
        .toList(),
    ProcedureFilterBy.name => data
        .where((element) => (element.description != null &&
            element.name!.toLowerCase().contains(search)))
        .toList(),
    ProcedureFilterBy.description => data
        .where((element) => (element.description != null &&
            element.description!.toLowerCase().contains(search)))
        .toList()
  };
*/
  if (filterSelected == ProcedureFilterBy.code) {
    var list = data
        .where((element) => (element.description != null &&
            element.code!.toLowerCase().contains(search)))
        .toList();
    list.sort(((a, b) => a.code!.compareTo(b.code!)));
    return list;
  }
  if (filterSelected == ProcedureFilterBy.name) {
    var list = data
        .where((element) => (element.description != null &&
            element.name!.toLowerCase().contains(search)))
        .toList();
    list.sort(((a, b) => a.name!.compareTo(b.name!)));
    return list;
  }
  if (filterSelected == ProcedureFilterBy.description) {
    var list = data
        .where((element) => (element.description != null &&
            element.description!.toLowerCase().contains(search)))
        .toList();
    list.sort(((a, b) => a.description!.compareTo(b.description!)));
    return list;
  }
  return data;
}
