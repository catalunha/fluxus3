import 'dart:developer';

import 'package:fluxus3/app/feature/status/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<StatusModel?> statusRead(StatusReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final status = await ref.read(statusRepositoryProvider).readById(id);
    if (status != null) {
      ref.watch(statusFormProvider.notifier).setModel(status);
      return status;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class StatusForm extends _$StatusForm {
  @override
  StatusFormState build() {
    return StatusFormState();
  }

  void setModel(StatusModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm(
      {required String name, required String description}) async {
    state = state.copyWith(status: StatusFormStatus.loading);
    try {
      StatusModel? statusTemp;
      if (state.model != null) {
        statusTemp = state.model!.copyWith(
          name: name,
          description: description,
        );
      } else {
        statusTemp = StatusModel(
          name: name,
          description: description,
        );
      }
      await ref.read(statusRepositoryProvider).update(statusTemp);
      ref.invalidate(statusListProvider);
      state = state.copyWith(status: StatusFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: StatusFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: StatusFormStatus.loading);
    try {
      await ref.read(statusRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(statusListProvider);
      state = state.copyWith(status: StatusFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: StatusFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
