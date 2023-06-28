import 'dart:developer';

import '../../list/controller/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/expertise_model.dart';
import '../../../../core/models/procedure_model.dart';
import '../../../../core/repositories/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<ProcedureModel?> procedureRead(ProcedureReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final procedure = await ref.read(procedureRepositoryProvider).readById(id);
    if (procedure != null) {
      ref.read(procedureFormProvider.notifier).setModel(procedure);
      ref.watch(expertiseSelectedProvider.notifier).set(procedure.expertise);
      return procedure;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class ExpertiseSelected extends _$ExpertiseSelected {
  @override
  ExpertiseModel? build() {
    return null;
  }

  void set(ExpertiseModel? value) {
    state = value;
  }
}

@riverpod
class ProcedureForm extends _$ProcedureForm {
  @override
  ProcedureFormState build() {
    return ProcedureFormState();
  }

  void setModel(ProcedureModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    required String code,
    required String description,
    required String cost,
    required String costProf,
  }) async {
    state = state.copyWith(status: ProcedureFormStatus.loading);
    try {
      final expertise = ref.read(expertiseSelectedProvider);
      ProcedureModel? procedureTemp;
      if (state.model != null) {
        procedureTemp = state.model!.copyWith(
          name: name,
          code: code,
          description: description,
          cost: double.tryParse(cost),
          costProf: double.tryParse(costProf),
          expertise: expertise,
        );
      } else {
        procedureTemp = ProcedureModel(
          name: name,
          code: code,
          description: description,
          cost: double.tryParse(cost),
          costProf: double.tryParse(costProf),
          expertise: expertise,
        );
      }
      await ref.read(procedureRepositoryProvider).update(procedureTemp);
      ref.invalidate(procedureListProvider);
      state = state.copyWith(status: ProcedureFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: ProcedureFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: ProcedureFormStatus.loading);
    try {
      await ref.read(procedureRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(procedureListProvider);
      state = state.copyWith(status: ProcedureFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: ProcedureFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
