import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<UserProfileModel> userProfileView(UserProfileViewRef ref,
    {required String id}) async {
  // return await ref.read(userProfileRepositoryProvider).readById(id);
  // final userProfile =
  //     await ref.read(userProfileRepositoryProvider).readById(id);
  // try {
  final userProfile =
      await ref.read(userProfileRepositoryProvider).readById(id);
  if (userProfile != null) {
    log('achei...');
    return userProfile;
  } else {
    log('NAO achei...');
    // throw Exception('Nao achei usuario com este id');
    // throw AsyncError('Não achei usuário com este id', StackTrace.current);
    throw Error.throwWithStackTrace(
        'Não achei usuário com este id', StackTrace.current);
  }
  // } catch (e) {
  //   // throw AsyncError('Não achei usuário com este id', StackTrace.current);

  //   // throw AsyncError('Não achei usuário com este id', StackTrace.current);
  // }
}
