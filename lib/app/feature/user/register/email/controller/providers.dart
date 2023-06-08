import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/repositories/providers.dart';
import '../../../../../data/b4a/b4a_exception.dart';
import 'states.dart';

part 'providers.g.dart';

final userRegisterEmailStatusProvider =
    StateProvider.autoDispose<UserRegisterEmailStatus>(
        (ref) => UserRegisterEmailStatus.initial);

final userRegisterEmailErrorProvider =
    StateProvider.autoDispose<String>((ref) => '');

@riverpod
class UserRegisterEmailForm extends _$UserRegisterEmailForm {
  @override
  bool build() {
    return false;
  }

  Future<void> submit({required String email, required String password}) async {
    ref.read(userRegisterEmailStatusProvider.notifier).state =
        UserRegisterEmailStatus.loading;

    try {
      final repository = ref.read(userRepositoryProvider);

      UserModel? user =
          await repository.register(email: email, password: password);
      if (user != null) {
        ref.read(userRegisterEmailStatusProvider.notifier).state =
            UserRegisterEmailStatus.success;
      } else {
        ref.read(userRegisterEmailErrorProvider.notifier).state =
            'Erro no cadastro do usuario';
        ref.read(userRegisterEmailStatusProvider.notifier).state =
            UserRegisterEmailStatus.error;
      }
    } on B4aException catch (e) {
      ref.read(userRegisterEmailErrorProvider.notifier).state = e.message;
      ref.read(userRegisterEmailStatusProvider.notifier).state =
          UserRegisterEmailStatus.error;
    } catch (e) {
      //log('$st');
      ref.read(userRegisterEmailErrorProvider.notifier).state =
          'Erro desconhecido em registrar seu cadastro';
      ref.read(userRegisterEmailStatusProvider.notifier).state =
          UserRegisterEmailStatus.error;
    }
  }
}
