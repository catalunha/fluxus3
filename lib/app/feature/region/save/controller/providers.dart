import 'dart:developer';

import 'package:fluxus3/app/feature/region/list/controller/providers.dart';
import 'package:fluxus3/app/feature/region/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/region_model.dart';
import '../../../../core/repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<RegionModel?> regionRead(RegionReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final region = await ref.read(regionRepositoryProvider).readById(id);
    if (region != null) {
      ref.read(regionFormProvider.notifier).setModel(region);
      return region;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class RegionForm extends _$RegionForm {
  @override
  RegionFormState build() {
    return RegionFormState();
  }

  void setModel(RegionModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String uf,
    required String city,
    required String name,
  }) async {
    state = state.copyWith(status: RegionFormStatus.loading);
    try {
      RegionModel? regionTemp;
      if (state.model != null) {
        regionTemp = state.model!.copyWith(
          name: name,
          uf: uf,
          city: city,
        );
      } else {
        regionTemp = RegionModel(
          name: name,
          uf: uf,
          city: city,
        );
      }
      await ref.read(regionRepositoryProvider).update(regionTemp);
      ref.invalidate(regionListProvider);
      state = state.copyWith(status: RegionFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: RegionFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: RegionFormStatus.loading);
    try {
      await ref.read(regionRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(regionListProvider);
      state = state.copyWith(status: RegionFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: RegionFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
