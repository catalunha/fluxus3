import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<UserProfileModel> userProfileAccess(UserProfileAccessRef ref,
    {required String id}) async {
  final userProfile =
      await ref.read(userProfileRepositoryProvider).readById(id);
  if (userProfile != null) {
    ref.read(isActiveProvider.notifier).state = userProfile.isActive;
    for (var access in userProfile.access) {
      ref.read(accessStateProvider.notifier).update(access.toAccessStatus);
    }
    return userProfile;
  } else {
    throw Error.throwWithStackTrace(
        'Não achei usuário com este id', StackTrace.current);
  }
}

final isActiveProvider = StateProvider<bool>((ref) {
  return false;
});

// @riverpod
@Riverpod(keepAlive: true)
class AccessState extends _$AccessState {
  @override
  List<AccessStatus> build() {
    return [];
  }

  void update(AccessStatus status) {
    int index = state.indexWhere((value) => value == status);
    if (index >= 0) {
      List<AccessStatus> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, status];
    }
  }
}
