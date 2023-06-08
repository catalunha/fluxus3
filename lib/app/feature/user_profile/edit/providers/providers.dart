import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import 'states.dart';

part 'providers.g.dart';

final userProfileEditStatusProvider =
    StateProvider.autoDispose<UserProfileEditStatus>(
        (ref) => UserProfileEditStatus.initial);

final userProfileEditErrorProvider =
    StateProvider.autoDispose<String>((ref) => '');

@riverpod
class UserProfileEdit extends _$UserProfileEdit {
  @override
  bool build() {
    return false;
  }

  Future<void> userProfileEditSubmitForm({required String name}) async {
    ref.read(userProfileEditStatusProvider.notifier).state =
        UserProfileEditStatus.loading;
    try {
      final repository = ref.read(userProfileRepositoryProvider);
      final authChNot = ref.read(authChNotProvider);

      UserProfileModel userProfileModel =
          authChNot.user!.userProfile!.copyWith(name: name);
      await repository.update(userProfileModel);
      authChNot.user = authChNot.user!.copyWith(userProfile: userProfileModel);
      ref.read(userProfileEditStatusProvider.notifier).state =
          UserProfileEditStatus.success;
    } catch (e) {
      ref.read(userProfileEditErrorProvider.notifier).state =
          'Erro em editar perfil';
      ref.read(userProfileEditStatusProvider.notifier).state =
          UserProfileEditStatus.error;
    }
  }
}
