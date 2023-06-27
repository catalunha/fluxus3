import 'dart:developer';

import 'package:fluxus3/app/feature/shared/list/controller/providers.dart';
import 'package:fluxus3/app/feature/shared/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/shared_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../patient/list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<SharedModel?> sharedRead(SharedReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final shared = await ref.read(sharedRepositoryProvider).readById(id);
    if (shared != null) {
      ref.read(sharedFormProvider.notifier).setModel(shared);
      return shared;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class SharedForm extends _$SharedForm {
  @override
  SharedFormState build() {
    return SharedFormState();
  }

  void setModel(SharedModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String history}) async {
    state = state.copyWith(status: SharedFormStatus.loading);
    try {
      SharedModel? sharedTemp;
      final auth = ref.read(authChNotProvider);

      if (state.model != null) {
        sharedTemp = state.model!.copyWith(history: history);
      } else {
        sharedTemp = SharedModel(
          professional: auth.user!.userProfile,
          patient: ref.read(sharedPatientSelectedProvider),
          history: history,
        );
      }
      await ref.read(sharedRepositoryProvider).update(sharedTemp);
      ref.invalidate(sharedListProvider);
      state = state.copyWith(status: SharedFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: SharedFormStatus.error, error: 'Erro em SharedFormProvider');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: SharedFormStatus.loading);
    try {
      await ref.read(sharedRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(sharedListProvider);
      state = state.copyWith(status: SharedFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: SharedFormStatus.error, error: 'Erro em SharedFormProvider');
    }
  }
}
