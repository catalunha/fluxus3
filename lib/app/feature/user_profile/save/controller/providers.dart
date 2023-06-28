import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/region_model.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';
import '../../../../data/b4a/utils/xfile_to_parsefile.dart';
import 'states.dart';

part 'providers.g.dart';

// @riverpod
// class XFile extends _$XFile {
//   @override
//   XFile? build() {
//     return null;
//   }

//   void set(XFile? value) {
//     state = value;
//   }
// }

final xFileProvider = StateProvider.autoDispose<XFile?>(
  (ref) {
    return null;
  },
  name: 'xFileProvider',
);

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
class UserProfileSaveForm extends _$UserProfileSaveForm {
  @override
  UserProfileSaveFormState build() {
    return UserProfileSaveFormState();
  }

  void setModel(UserProfileModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    String? name,
    String? nickname,
    String? cpf,
    String? phone,
    String? address,
    String? register,
    bool? isFemale,
    DateTime? birthday,
  }) async {
    state = state.copyWith(status: UserProfileSaveFormStatus.loading);

    try {
      final repository = ref.read(userProfileRepositoryProvider);
      final auth = ref.read(authChNotProvider);
      final region = ref.read(regionSelectedProvider);

      UserProfileModel userProfileModel = auth.user!.userProfile!.copyWith(
        nickname: nickname,
        name: name,
        cpf: cpf,
        phone: phone,
        address: address,
        register: register,
        isFemale: isFemale,
        birthday: birthday,
        region: region,
      );
      await repository.update(userProfileModel);
      final xFile = ref.read(xFileProvider);
      if (xFile != null) {
        final String? photoUrl = await XFileToParseFile.xFileToParseFile(
          xfile: xFile,
          className: UserProfileEntity.className,
          objectId: auth.user!.userProfile!.id,
          objectAttribute: 'photo',
        );
        userProfileModel = userProfileModel.copyWith(photo: photoUrl);
      }
      auth.user = auth.user!.copyWith(userProfile: userProfileModel);
      state = state.copyWith(status: UserProfileSaveFormStatus.success);
    } catch (e) {
      state = state.copyWith(
          status: UserProfileSaveFormStatus.error,
          error: 'Erro em editar perfim');
    }
  }
}
