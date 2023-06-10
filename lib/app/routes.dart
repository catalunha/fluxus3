import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/authentication/riverpod/auth_prov.dart';
import 'core/authentication/riverpod/auth_state.dart';
import 'feature/error/error_page.dart';
import 'feature/region/select/region_select_page.dart';
import 'feature/splash/splash_page.dart';
import 'feature/user/login/user_login_page.dart';
import 'feature/user/register/email/user_register_email.page.dart';
import 'feature/user_profile/access/user_profile_access_page.dart';
import 'feature/user_profile/list/user_profile_list_page.dart';
import 'feature/user_profile/save/user_profile_edit_page.dart';
import 'feature/home/home_page.dart';
import 'feature/user_profile/select/user_profile_select_page.dart';
import 'feature/user_profile/view/user_profile_view_page.dart';

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
              path: AppPage.userProfileSave.path,
              name: AppPage.userProfileSave.name,
              builder: (context, state) {
                return UserProfileEditPage(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.userProfileList.path,
              name: AppPage.userProfileList.name,
              builder: (context, state) {
                return UserProfileListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.userProfileView.path,
                  name: AppPage.userProfileView.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] as String;
                    return UserProfileViewPage(
                      key: state.pageKey,
                      userProfileId: id,
                    );
                  },
                ),
                GoRoute(
                  path: AppPage.userProfileAccess.path,
                  name: AppPage.userProfileAccess.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] as String;
                    return UserProfileAccessPage(
                      key: state.pageKey,
                      userProfileId: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.userProfileSelect.path,
              name: AppPage.userProfileSelect.name,
              builder: (context, state) {
                final isSingleValue = state.extra as bool;
                return UserProfileSelectPage(
                  key: state.pageKey,
                  isSingleValue: isSingleValue,
                );
              },
            ),
            GoRoute(
              path: AppPage.regionSelect.path,
              name: AppPage.regionSelect.name,
              builder: (context, state) {
                return RegionSelectPage(
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
/home
/home/userProfileSave
/home/userProfileList
/home/userProfileList/userProfileView
/home/userProfileList/userProfileAccess

/home/userProfileSelect
/home/regionSelect

*/

enum AppPage {
  splash('/', 'splash'),
  login('/login', 'login'),
  registerEmail('registerEmail', 'registerEmail'),
  home('/home', 'home'),
  userProfileSave('userProfileSave', 'userProfileSave'),
  userProfileList('userProfileList', 'userProfileList'),
  userProfileView('userProfileView/:id', 'userProfileView'),
  userProfileAccess('userProfileAccess/:id', 'userProfileAccess'),
  userProfileSelect('userProfileSelect', 'userProfileSelect'),
  regionSelect('regionSelect', 'regionSelect');

  final String path;
  final String name;
  const AppPage(this.path, this.name);
}
