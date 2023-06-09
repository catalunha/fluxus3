import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';
import '../../../../data/b4a/utils/xfile_to_parsefile.dart';
import 'states.dart';

part 'providers.g.dart';

final userProfileSaveStatusProvider =
    StateProvider.autoDispose<UserProfileSaveStatus>(
        (ref) => UserProfileSaveStatus.initial);

final userProfileSaveErrorProvider =
    StateProvider.autoDispose<String>((ref) => '');

final xFileProvider = StateProvider<XFile?>(
  (ref) {
    return null;
  },
  name: 'xFileProvider',
);

@riverpod
class UserProfileSave extends _$UserProfileSave {
  @override
  bool build() {
    return false;
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
    ref.read(userProfileSaveStatusProvider.notifier).state =
        UserProfileSaveStatus.loading;
    try {
      final repository = ref.read(userProfileRepositoryProvider);
      final auth = ref.read(authChNotProvider);

      UserProfileModel userProfileModel = auth.user!.userProfile!.copyWith(
        nickname: nickname,
        name: name,
        cpf: cpf,
        phone: phone,
        address: address,
        register: register,
        isFemale: isFemale,
        birthday: birthday,
        // region: state.region,
      );
      await repository.update(userProfileModel);
      final xFile = ref.read(xFileProvider);
      if (xFile != null) {
        String? photoUrl = await XFileToParseFile.xFileToParseFile(
          xfile: xFile,
          className: UserProfileEntity.className,
          objectId: auth.user!.userProfile!.id,
          objectAttribute: 'photo',
        );
        userProfileModel = userProfileModel.copyWith(photo: photoUrl);
      }
      auth.user = auth.user!.copyWith(userProfile: userProfileModel);
      ref.read(userProfileSaveStatusProvider.notifier).state =
          UserProfileSaveStatus.success;
    } catch (e) {
      ref.read(userProfileSaveErrorProvider.notifier).state =
          'Erro em editar perfil';
      ref.read(userProfileSaveStatusProvider.notifier).state =
          UserProfileSaveStatus.error;
    }
  }
}
