import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../../../data/b4a/entity/patient_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<PatientModel>> patientList(PatientListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
  query.orderByAscending('name');
  final list = await ref.watch(patientRepositoryProvider).list(query, cols: {
    "${PatientEntity.className}.cols": [
      PatientEntity.name,
      // PatientEntity.nickname,
      PatientEntity.phone,
      // PatientEntity.healthPlans,
    ],
  });
  ref.watch(patientListDataProvider.notifier).set(list);
  return list;
}

@Riverpod(keepAlive: true)
class SharedPatientSelected extends _$SharedPatientSelected {
  @override
  PatientModel? build() {
    return null;
  }

  void set(PatientModel value) {
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
  // final filterSelected = ref.watch(patientFilteredByProvider);
  final search = ref.watch(patientSearchProvider);
  final data = ref.watch(patientListDataProvider);

  return data
      .where((element) => (element.name != null &&
          element.name!.toLowerCase().contains(search)))
      .toList();
}

/*
@riverpod
List<PatientModel> patientFiltered(PatientFilteredRef ref) {
  // final filterSelected = ref.watch(patientFilteredByProvider);
  final search = ref.watch(patientSearchProvider);
  final data = ref.watch(patientListDataProvider);

  return switch (filterSelected) {
    PatientFilterStatus.name => data
        .where((element) => (element.name != null &&
            element.name!.toLowerCase().contains(search)))
        .toList(),
    PatientFilterStatus.nickname => data
        .where((element) => (element.nickname != null &&
            element.nickname!.toLowerCase().contains(search)))
        .toList(),
    PatientFilterStatus.phone => data
        .where((element) => (element.phone != null &&
            element.phone!.toLowerCase().contains(search)))
        .toList(),
  };
}
*/