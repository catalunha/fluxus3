import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/b4a_exception.dart';
import 'states.dart';

part 'providers.g.dart';

final userLoginStatusProvider = StateProvider.autoDispose<UserLoginStatus>(
    (ref) => UserLoginStatus.initial);

final userLoginErrorProvider = StateProvider.autoDispose<String>((ref) => '');

@riverpod
class UserLoginEmailForm extends _$UserLoginEmailForm {
  @override
  bool build() {
    return false;
  }

  Future<void> submit({required String email, required String password}) async {
    ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.loading;

    try {
      final repository = ref.read(userRepositoryProvider);
      final authChNotProvIR = ref.read(authChNotProvider);

      UserModel? user =
          await repository.login(email: email, password: password);
      authChNotProvIR.user = user;
      ref.read(userLoginStatusProvider.notifier).state =
          UserLoginStatus.success;
    } on B4aException catch (e) {
      ref.read(userLoginErrorProvider.notifier).state = e.message;
      ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.error;
      //log('$st');
    } catch (e) {
      ref.read(userLoginErrorProvider.notifier).state =
          'Erro desconhecido no login.';
      ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.error;
      //log('$st');
    }
  }

  Future<void> resetPassword({required String email}) async {
    ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.loading;

    try {
      final repository = ref.read(userRepositoryProvider);

      await repository.requestPasswordReset(email);
      ref.read(userLoginStatusProvider.notifier).state =
          UserLoginStatus.success;
    } on B4aException catch (e) {
      ref.read(userLoginErrorProvider.notifier).state = e.message;
      ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.error;
      //log('$st');
    } catch (e) {
      ref.read(userLoginErrorProvider.notifier).state =
          'Erro desconhecido ao resetar senha.';
      ref.read(userLoginStatusProvider.notifier).state = UserLoginStatus.error;
      //log('$st');
      //log('$st');
    }
  }
}
