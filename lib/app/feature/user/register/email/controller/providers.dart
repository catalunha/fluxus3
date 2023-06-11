import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/repositories/providers.dart';
import '../../../../../data/b4a/b4a_exception.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class UserRegisterEmailForm extends _$UserRegisterEmailForm {
  @override
  UserRegisterEmailFormState build() {
    return UserRegisterEmailFormState();
  }

  Future<void> submit({required String email, required String password}) async {
    state = state.copyWith(status: UserRegisterEmailFormStatus.loading);

    try {
      final repository = ref.read(userRepositoryProvider);

      UserModel? user =
          await repository.register(email: email, password: password);
      if (user != null) {
        state = state.copyWith(status: UserRegisterEmailFormStatus.success);
      } else {
        state = state.copyWith(
            status: UserRegisterEmailFormStatus.error,
            error: 'Erro ao cadastrar usuario');
      }
    } on B4aException catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: UserRegisterEmailFormStatus.error, error: e.message);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: UserRegisterEmailFormStatus.error,
          error: 'Erro desconhecido ao cadastrar usaurio');
    }
  }
}
