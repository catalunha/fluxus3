import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../data/b4a/entity/patient_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<PatientModel>> patientSelect(PatientSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(patientRepositoryProvider).list(query);
  return list;
}

@riverpod
class PatientSelected extends _$PatientSelected {
  @override
  List<PatientModel> build() {
    return [];
  }

  void toggle(PatientModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<PatientModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
