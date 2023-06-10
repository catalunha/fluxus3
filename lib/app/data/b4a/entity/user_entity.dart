import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/user_model.dart';
import 'user_profile_entity.dart';

class UserEntity {
  static const String className = '_User';
  // Nome do campo App = no Database
  static const String id = 'objectId';
  static const String userName = 'username';
  static const String email = 'email';
  static const String userProfile = 'userProfile';

  Future<UserModel> toModel(ParseObject parseUser) async {
    return UserModel(
      id: parseUser.objectId!,
      userName: parseUser.get(UserEntity.userName),
      email: parseUser.get(UserEntity.email),
      userProfile: parseUser.get(UserEntity.userProfile) != null
          ? await UserProfileEntity()
              .toModel(parseUser.get(UserEntity.userProfile))
          : null,
    );
  }
}
