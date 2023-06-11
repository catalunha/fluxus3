import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/b4a_exception.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class UserLoginEmailForm extends _$UserLoginEmailForm {
  @override
  UserLoginFormState build() {
    return UserLoginFormState();
  }

  Future<void> submit({required String email, required String password}) async {
    state = state.copyWith(status: UserLoginFormStatus.loading);
    try {
      final repository = ref.read(userRepositoryProvider);
      final authChNotProvIR = ref.read(authChNotProvider);

      UserModel? user =
          await repository.login(email: email, password: password);
      authChNotProvIR.user = user;
      state = state.copyWith(status: UserLoginFormStatus.success);
    } on B4aException catch (e, st) {
      log('$e');
      log('$st');
      state =
          state.copyWith(status: UserLoginFormStatus.error, error: e.message);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: UserLoginFormStatus.error,
          error: 'Erro desconhecido no login');
    }
  }

  Future<void> resetPassword({required String email}) async {
    state = state.copyWith(status: UserLoginFormStatus.loading);

    try {
      final repository = ref.read(userRepositoryProvider);

      await repository.requestPasswordReset(email);
      state = state.copyWith(status: UserLoginFormStatus.success);
    } on B4aException catch (e, st) {
      log('$e');
      log('$st');
      state =
          state.copyWith(status: UserLoginFormStatus.error, error: e.message);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: UserLoginFormStatus.error,
          error: 'Erro desconhecido ao reset senha');
    }
  }
}
