import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/b4a/b4a_exception.dart';
import '../../../data/b4a/init_back4app.dart';
import '../../repositories/providers.dart';
import 'auth_state.dart';

part 'auth_prov.g.dart';

// @riverpod
// AuthChNot authChNot(AuthChNotRef ref) {
//   return AuthChNot();
// }

final authChNotProvider = ChangeNotifierProvider<AuthChNot>((ref) {
  return AuthChNot();
});

// @Riverpod(keepAlive: true, dependencies: [authChNotProvider])
@riverpod
void logout(LogoutRef ref) {
  final repository = ref.read(userRepositoryProvider);
  repository.logout();
  // final authChNot = ref.watch(authChNotProvider);
  // authChNot.logout();
}

// final authStatusStProv = StateProvider<AuthStatus>((ref) => AuthStatus.unknown);
// final authErrorMsgProv = StateProvider<String>((ref) => '');
// final currentUser = Provider<UserModel>((ref) => throw UnimplementedError());

final authCheckFutProvider = FutureProvider<void>((ref) async {
  final authChNotProvIR = ref.read(authChNotProvider);
  final userRepositoryProvIR = ref.read(userRepositoryProvider);
  final InitBack4app initBack4app = InitBack4app();
  try {
    final bool initParse = await initBack4app.init();

    ////log('+++ AuthenticationEventInitial 1');
    if (initParse) {
      ////log('+++ AuthenticationEventInitial 2');
      final user = await userRepositoryProvIR.hasUserLogged();

      ////log('+++ AuthenticationEventInitial 3');
      if (user != null) {
        log('+++ AuthenticationEventInitial 4');
        log('user.userProfile!.isActive: ${user.userProfile!.isActive}');
        if (user.userProfile!.isActive == true) {
          ////log('+++ AuthenticationEventInitial 5');
          authChNotProvIR.user = user;

          ////log('Já logado ${user.email}');
        } else {
          ////log('+++ AuthenticationEventInitial 7');
          await userRepositoryProvIR.logout();
          authChNotProvIR.logout();
        }
      } else {
        ////log('+++ AuthenticationEventInitial 6');
        authChNotProvIR.logout();
      }
    }
  } on B4aException catch (e, st) {
    log('+++ _onAuthenticationEventInitial 8');
    log('$e');
    log('$st');
    authChNotProvIR.status = AuthStatus.databaseError;
  } catch (e, st) {
    log('+++ _onAuthenticationEventInitial 9');
    log('$e');
    log('$st');
    authChNotProvIR.status = AuthStatus.unauthenticated;
  }
});
