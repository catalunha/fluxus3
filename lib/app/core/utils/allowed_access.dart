import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../authentication/riverpod/auth_prov.dart';

part 'allowed_access.g.dart';

@riverpod
class AllowedAccess extends _$AllowedAccess {
  @override
  bool build() {
    return false;
  }

  bool consultForSec() {
    final auth = ref.read(authChNotProvider);
    return auth.user?.userProfile?.access.any((element) => element == 'sec') ??
        false;
  }

  bool consultForProf() {
    final auth = ref.read(authChNotProvider);

    return auth.user?.userProfile?.access.any((element) => element == 'prof') ??
        false;
  }

  bool consultForAdmin() {
    final auth = ref.read(authChNotProvider);

    return auth.user?.userProfile?.access
            .any((element) => element == 'admin') ??
        false;
  }
}
