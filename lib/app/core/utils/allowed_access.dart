import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../authentication/riverpod/auth_prov.dart';

part 'allowed_access.g.dart';

enum Access { admin, aval, prof, sec }

@riverpod
class AllowedAccess extends _$AllowedAccess {
  @override
  bool build() {
    return false;
  }

  bool consultFor(List<String> access) {
    final auth = ref.read(authChNotProvider);
    return auth.user?.userProfile?.access
            .any((element) => access.contains(element)) ??
        false;
  }
}
