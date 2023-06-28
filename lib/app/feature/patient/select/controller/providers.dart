import '../../../../core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../data/b4a/entity/patient_entity.dart';

part 'providers.g.dart';

// @riverpod
@Riverpod(keepAlive: true)
FutureOr<List<PatientModel>> patientSelect(PatientSelectRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(patientRepositoryProvider).list(query, cols: {
    '${PatientEntity.className}.cols': [
      PatientEntity.name,
      // PatientEntity.nickname,
      PatientEntity.phone,
      // PatientEntity.healthPlans,
    ],
  });
  ref.watch(patientListDataProvider.notifier).set(list);

  return list;
}

// @riverpod
@Riverpod(keepAlive: true)
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
List<PatientModel> patientFiltered(PatientFilteredRef ref) {
  final search = ref.watch(patientSearchProvider);
  final data = ref.watch(patientListDataProvider);

  return data
      .where((element) => (element.name != null &&
          element.name!.toLowerCase().contains(search)))
      .toList();
}

@riverpod
class PatientSelected extends _$PatientSelected {
  @override
  List<PatientModel> build() {
    return [];
  }

  void toggle(PatientModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<PatientModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
