import 'dart:developer';

import 'package:fluxus3/app/feature/hour/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/hour_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<HourModel?> hourRead(HourReadRef ref, {required String? id}) async {
  if (id != null) {
    final hour = await ref.read(hourRepositoryProvider).readById(id);
    if (hour != null) {
      ref.watch(hourFormProvider.notifier).setModel(hour);
      ref.watch(hourIsActiveProvider.notifier).set(hour.isActive ?? false);
      return hour;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class HourIsActive extends _$HourIsActive {
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
class HourForm extends _$HourForm {
  @override
  HourFormState build() {
    return HourFormState();
  }

  void setModel(HourModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    required String start,
    required String end,
  }) async {
    state = state.copyWith(status: HourFormStatus.loading);
    try {
      HourModel? hourTemp;
      if (state.model != null) {
        hourTemp = state.model!.copyWith(
          name: name,
          start: start,
          end: end,
          isActive: ref.read(hourIsActiveProvider),
        );
      } else {
        hourTemp = HourModel(
          name: name,
          start: start,
          end: end,
          isActive: ref.read(hourIsActiveProvider),
        );
      }
      await ref.read(hourRepositoryProvider).update(hourTemp);
      ref.invalidate(hourListProvider);
      state = state.copyWith(status: HourFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: HourFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: HourFormStatus.loading);
    try {
      await ref.read(hourRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(hourListProvider);
      state = state.copyWith(status: HourFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: HourFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
