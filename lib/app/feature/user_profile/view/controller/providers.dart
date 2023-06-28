import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<UserProfileModel> userProfileView(UserProfileViewRef ref,
    {required String id}) async {
  // return await ref.read(userProfileRepositoryProvider).readById(id);
  // final userProfile =
  //     await ref.read(userProfileRepositoryProvider).readById(id);
  // try {
  final userProfile =
      await ref.read(userProfileRepositoryProvider).readById(id, cols: {
    '${UserProfileEntity.className}.cols': [
      UserProfileEntity.userName,
      UserProfileEntity.email,
      UserProfileEntity.access,
      UserProfileEntity.isActive,
      UserProfileEntity.nickname,
      UserProfileEntity.name,
      UserProfileEntity.cpf,
      UserProfileEntity.register,
      UserProfileEntity.phone,
      UserProfileEntity.photo,
      UserProfileEntity.isFemale,
      UserProfileEntity.birthday,
      UserProfileEntity.address,
      UserProfileEntity.region,
      UserProfileEntity.offices,
      UserProfileEntity.expertises,
      UserProfileEntity.procedures,
    ]
  });
  if (userProfile != null) {
    return userProfile;
  } else {
    // throw Exception('Nao achei usuario com este id');
    // throw AsyncError('Não achei usuário com este id', StackTrace.current);
    throw Error.throwWithStackTrace(
        'Não achei usuário com este id', StackTrace.current);
  }
}
