import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<PatientModel>> patientList(PatientListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
  query.orderByAscending('name');
  return await ref.read(patientRepositoryProvider).list(query);
}

@riverpod
class PatientFilteredBy extends _$PatientFilteredBy {
  @override
  PatientFilterStatus build() {
    return PatientFilterStatus.name;
  }

  void set(PatientFilterStatus value) {
    state = value;
  }
}

@riverpod
class PatientSearch extends _$PatientSearch {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@riverpod
class PatientListData extends _$PatientListData {
  @override
  List<PatientModel> build() {
    return [];
  }

  void set(List<PatientModel> value) {
    state = value;
  }
}

@riverpod
List<PatientModel> patientFiltered(PatientFilteredRef ref) {
  final filterSelected = ref.watch(patientFilteredByProvider);
  final search = ref.watch(patientSearchProvider);
  final data = ref.read(patientListDataProvider);

  return switch (filterSelected) {
    PatientFilterStatus.name => data
        .where((element) =>
            (element.name != null && element.name!.startsWith(search)))
        .toList(),
    PatientFilterStatus.cpf => data
        .where((element) =>
            (element.cpf != null && element.cpf!.startsWith(search)))
        .toList(),
    PatientFilterStatus.phone => data
        .where((element) =>
            (element.phone != null && element.phone!.startsWith(search)))
        .toList(),
    _ => data
  };
}
