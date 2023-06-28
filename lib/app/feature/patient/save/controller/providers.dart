import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/healthplan_model.dart';
import '../../../../core/models/patient_model.dart';
import '../../../../core/models/region_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/patient_entity.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<PatientModel?> patientRead(PatientReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final patient =
        await ref.read(patientRepositoryProvider).readById(id, cols: {
      '${PatientEntity.className}.cols': [
        PatientEntity.name,
        PatientEntity.email,
        PatientEntity.nickname,
        PatientEntity.cpf,
        PatientEntity.phone,
        PatientEntity.isFemale,
        PatientEntity.birthday,
        PatientEntity.address,
        PatientEntity.region,
        PatientEntity.family,
        PatientEntity.healthPlans,
      ],
      '${PatientEntity.className}.pointers': [PatientEntity.region],
    });
    if (patient != null) {
      ref.watch(patientFormProvider.notifier).setModel(patient);
      ref
          .watch(patientIsFemaleProvider.notifier)
          .set(patient.isFemale ?? false);
      ref.watch(birthDayProvider.notifier).set(patient.birthday);
      ref.watch(regionSelectedProvider.notifier).set(patient.region);
      ref.watch(parentsOriginalProvider.notifier).set(patient.family ?? []);
      for (var element in patient.family ?? []) {
        ref.watch(parentsSelectedProvider.notifier).update(element);
      }
      ref
          .watch(healthPlansOriginalProvider.notifier)
          .set(patient.healthPlans ?? []);
      for (var element in patient.healthPlans ?? []) {
        ref.watch(healthPlansSelectedProvider.notifier).add(element);
      }
      return patient;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class BirthDay extends _$BirthDay {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class PatientIsFemale extends _$PatientIsFemale {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class RegionSelected extends _$RegionSelected {
  @override
  RegionModel? build() {
    return null;
  }

  void set(RegionModel? value) {
    state = value;
  }
}

@riverpod
class ParentsOriginal extends _$ParentsOriginal {
  @override
  List<PatientModel> build() {
    return [];
  }

  void set(List<PatientModel> list) {
    state = list;
  }
}

@riverpod
class ParentsSelected extends _$ParentsSelected {
  @override
  List<PatientModel> build() {
    return [];
  }

  void update(PatientModel model) {
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

@riverpod
class HealthPlansOriginal extends _$HealthPlansOriginal {
  @override
  List<HealthPlanModel> build() {
    return [];
  }

  void set(List<HealthPlanModel> list) {
    state = list;
  }
}

@riverpod
class HealthPlansSelected extends _$HealthPlansSelected {
  @override
  List<HealthPlanModel> build() {
    return [];
  }

  void add(HealthPlanModel model) {
    state = [...state, model];
  }

  void update(HealthPlanModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<HealthPlanModel> temp = [...state];
      temp.replaceRange(index, index + 1, [model]);
      state = [...temp];
    }
  }

  Future<void> delete(String id) async {
    final int index = state.indexWhere((value) => value.id == id);
    if (index >= 0) {
      await ref.read(healthPlanRepositoryProvider).delete(id);
      final List<HealthPlanModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    }
  }
}

@riverpod
class PatientForm extends _$PatientForm {
  @override
  PatientFormState build() {
    return PatientFormState();
  }

  void setModel(PatientModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    required String email,
    required String nickname,
    required String phone,
    required String cpf,
    required String address,
  }) async {
    state = state.copyWith(status: PatientFormStatus.loading);
    try {
      final region = ref.read(regionSelectedProvider);
      final birthDay = ref.read(birthDayProvider);

      PatientModel? patientTemp;
      if (state.model != null) {
        patientTemp = state.model!.copyWith(
          name: name,
          nickname: nickname,
          email: email,
          phone: phone,
          cpf: cpf,
          address: address,
          region: region,
          birthday: birthDay,
          isFemale: ref.read(patientIsFemaleProvider),
        );
      } else {
        patientTemp = PatientModel(
          name: name,
          email: email,
          nickname: nickname,
          phone: phone,
          cpf: cpf,
          address: address,
          region: region,
          birthday: birthDay,
          isFemale: ref.read(patientIsFemaleProvider),
        );
      }
      final newPatientId =
          await ref.read(patientRepositoryProvider).update(patientTemp);
      await _updateRelations(
        modelId: newPatientId,
        originalList: ref.read(parentsOriginalProvider),
        selectedList: ref.read(parentsSelectedProvider),
        relationColumn: 'family',
        relationTable: 'Patient',
      );
      await _updateRelations(
        modelId: newPatientId,
        originalList: ref.read(healthPlansOriginalProvider),
        selectedList: ref.read(healthPlansSelectedProvider),
        relationColumn: 'healthPlans',
        relationTable: 'HealthPlan',
      );
      ref.invalidate(patientListProvider);
      state = state.copyWith(status: PatientFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: PatientFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: PatientFormStatus.loading);
    try {
      // await ref.read(patientRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(patientListProvider);
      state = state.copyWith(status: PatientFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: PatientFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<List<dynamic>> _updateRelations({
    required String modelId,
    required List<dynamic> originalList,
    required List<dynamic> selectedList,
    required String relationColumn,
    required String relationTable,
  }) async {
    final List<dynamic> listResult = [...selectedList];
    final List<dynamic> listFinal = [...originalList];
    final repository = ref.read(patientRepositoryProvider);

    for (var original in originalList) {
      final int index =
          selectedList.indexWhere((model) => model.id == original.id);
      if (index < 0) {
        await repository.updateRelation(
          objectId: modelId,
          relationColumn: relationColumn,
          relationTable: relationTable,
          ids: [original.id!],
          add: false,
        );
        listFinal.removeWhere((element) => element.id == original.id);
      } else {
        listResult.removeWhere((element) => element.id == original.id);
      }
    }
    for (var result in listResult) {
      await repository.updateRelation(
        objectId: modelId,
        relationColumn: relationColumn,
        relationTable: relationTable,
        ids: [result.id!],
        add: true,
      );
      listFinal.add(result);
    }
    return listFinal;
  }
}
