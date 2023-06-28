import 'dart:developer';

import '../../list/controller/providers.dart';
import 'states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/expertise_model.dart';
import '../../../../core/repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<ExpertiseModel?> expertiseRead(ExpertiseReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final expertise = await ref.read(expertiseRepositoryProvider).readById(id);
    if (expertise != null) {
      ref.read(expertiseFormProvider.notifier).setModel(expertise);
      return expertise;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class ExpertiseForm extends _$ExpertiseForm {
  @override
  ExpertiseFormState build() {
    return ExpertiseFormState();
  }

  void setModel(ExpertiseModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String name}) async {
    state = state.copyWith(status: ExpertiseFormStatus.loading);
    try {
      ExpertiseModel? expertiseTemp;
      if (state.model != null) {
        expertiseTemp = state.model!.copyWith(name: name);
      } else {
        expertiseTemp = ExpertiseModel(name: name);
      }
      await ref.read(expertiseRepositoryProvider).update(expertiseTemp);
      ref.invalidate(expertiseListProvider);
      state = state.copyWith(status: ExpertiseFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: ExpertiseFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: ExpertiseFormStatus.loading);
    try {
      await ref.read(expertiseRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(expertiseListProvider);
      state = state.copyWith(status: ExpertiseFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: ExpertiseFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
