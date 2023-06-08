import 'user_profile_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String email,
    UserProfileModel? userProfile,
  }) = _UserModel;
}
