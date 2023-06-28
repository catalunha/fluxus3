import 'dart:developer';

import '../../list/controller/providers.dart';
import 'states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/office_model.dart';
import '../../../../core/repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<OfficeModel?> officeRead(OfficeReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final office = await ref.read(officeRepositoryProvider).readById(id);
    if (office != null) {
      ref.read(officeFormProvider.notifier).setModel(office);
      return office;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class OfficeForm extends _$OfficeForm {
  @override
  OfficeFormState build() {
    return OfficeFormState();
  }

  void setModel(OfficeModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String name}) async {
    state = state.copyWith(status: OfficeFormStatus.loading);
    try {
      OfficeModel? officeTemp;
      if (state.model != null) {
        officeTemp = state.model!.copyWith(name: name);
      } else {
        officeTemp = OfficeModel(name: name);
      }
      await ref.read(officeRepositoryProvider).update(officeTemp);
      ref.invalidate(officeListProvider);
      state = state.copyWith(status: OfficeFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: OfficeFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: OfficeFormStatus.loading);
    try {
      await ref.read(officeRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(officeListProvider);
      state = state.copyWith(status: OfficeFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: OfficeFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
