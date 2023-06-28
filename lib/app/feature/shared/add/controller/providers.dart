import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../list/controller/providers.dart';
import 'states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/shared_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/shared_entity.dart';
import '../../../../data/b4a/utils/file_to_parsefile.dart';
import '../../patient/list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<SharedModel?> sharedRead(SharedReadRef ref,
    {required String? id}) async {
  if (id != null) {
    final shared = await ref.read(sharedRepositoryProvider).readById(id, cols: {
      '${SharedEntity.className}.cols': [
        SharedEntity.professional,
        SharedEntity.patient,
        SharedEntity.description,
        SharedEntity.document,
        SharedEntity.isPublic,
      ],
      '${SharedEntity.className}.pointers': [
        SharedEntity.professional,
        SharedEntity.patient,
      ],
    });
    if (shared != null) {
      ref.read(sharedFormProvider.notifier).setModel(shared);
      return shared;
    }
  }
  return null;
}

final xFileProvider = StateProvider<FilePickerResult?>(
  (ref) {
    return null;
  },
  name: 'xFileProvider',
);

@riverpod
class SharedForm extends _$SharedForm {
  @override
  SharedFormState build() {
    return SharedFormState();
  }

  void setModel(SharedModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String description}) async {
    state = state.copyWith(status: SharedFormStatus.loading);
    try {
      SharedModel? sharedTemp;
      final auth = ref.read(authChNotProvider);
      // final sharedIsPublic = ref.read(sharedIsPublicProvider);
      // if (state.model != null) {
      //   sharedTemp = state.model!.copyWith(
      //     description: description,
      //     isPublic: false,
      //   );
      // } else {
      sharedTemp = SharedModel(
        professional: auth.user!.userProfile,
        patient: ref.read(sharedPatientSelectedProvider),
        description: description,
        isPublic: false,
      );
      // }
      final sharedId =
          await ref.read(sharedRepositoryProvider).update(sharedTemp);
      final xFile = ref.read(xFileProvider);
      // log('xFile: ${xFile?.path}');
      if (xFile != null) {
        log('xFile....');
        await FileToParseFile.xFileToParseFile(
          xfile: xFile,
          className: SharedEntity.className,
          objectId: sharedId,
          objectAttribute: 'document',
        );
      }
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

// @riverpod
// class SharedIsPublic extends _$SharedIsPublic {
//   @override
//   bool build() {
//     return false;
//   }

//   void toggle() {
//     state = !state;
//   }

//   void set(bool value) {
//     state = value;
//   }
// }
