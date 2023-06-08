import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/authentication/riverpod/auth_prov.dart';
import 'core/authentication/riverpod/auth_state.dart';
import 'feature/error/error_page.dart';
import 'feature/splash/splash_page.dart';
import 'feature/user/login/user_login_page.dart';
import 'feature/user/register/email/user_register_email.page.dart';
import 'feature/user_profile/edit/user_profile_edit_page.dart';
import 'home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final goRouterProv = Provider<GoRouter>(
  (ref) {
    final authChNotProvIR = ref.watch(authChNotProvider);
    return GoRouter(
      navigatorKey: _rootNavigator,
      debugLogDiagnostics: true,
      initialLocation: AppPage.splash.path,
      refreshListenable: authChNotProvIR,
      redirect: (context, state) {
        final authStatus = authChNotProvIR.status;
        // //log('+++ redirect');
        // //log('state.location: ${state.location}');
        // //log('authStatusStProvIR: $authStatus');
        if (authStatus == AuthStatus.unauthenticated &&
            state.location != '/login/registerEmail') {
          // //log('--- redirected 1 to login');
          return AppPage.login.path;
        }
        if (authStatus == AuthStatus.authenticated &&
            (state.location == AppPage.login.path ||
                state.location == AppPage.splash.path)) {
          // //log('--- redirected 2 to home');
          return AppPage.home.path;
        }
        // //log('--- redirected 3 to ${state.location}');

        return null;
      },
      routes: [
        GoRoute(
          path: AppPage.splash.path,
          name: AppPage.splash.name,
          builder: (context, state) => SplashPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: AppPage.login.path,
          name: AppPage.login.name,
          builder: (context, state) => UserLoginPage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: AppPage.registerEmail.path,
              name: AppPage.registerEmail.name,
              builder: (context, state) => UserRegisterEmailPage(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppPage.home.path,
          name: AppPage.home.name,
          builder: (context, state) => HomePage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: AppPage.userProfileEdit.path,
              name: AppPage.userProfileEdit.name,
              builder: (context, state) {
                return UserProfileEditPage(
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(
        key: state.pageKey,
        errorMsg: state.error.toString(),
      ),
    );
  },
);

/*
/splash
/login
/login/registerEmail
/home (com levels)
/home/userProfile/edit
/home/tasks
/home/tasks/calcStart
/home/tasks/calcStart/calcs[1...100]
/home/tasks/calcStart/calcs/calcReport
*/

enum AppPage {
  splash('/', 'splash'),
  login('/login', 'login'),
  registerEmail('registerEmail', 'registerEmail'),
  home('/home', 'home'),
  userProfileEdit('userProfile/edit', 'userProfileEdit');

  final String path;
  final String name;
  const AppPage(this.path, this.name);
}
