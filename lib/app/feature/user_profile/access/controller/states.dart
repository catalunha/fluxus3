import '../../../../core/models/user_profile_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum AccessStatus { admin, sec, prof, fin, none }

extension StringToAccessStatus on String {
  AccessStatus get toAccessStatus {
    return switch (this) {
      'admin' => AccessStatus.admin,
      'sec' => AccessStatus.sec,
      'prof' => AccessStatus.prof,
      'fin' => AccessStatus.fin,
      _ => AccessStatus.none,
    };
  }
}

enum UserProfileAccessSaveStatus { initial, loading, success, error }

enum UserProfileAccessFormStatus { initial, loading, success, error }

@freezed
abstract class UserProfileAccessFormState with _$UserProfileAccessFormState {
  factory UserProfileAccessFormState({
    @Default(UserProfileAccessFormStatus.initial)
    UserProfileAccessFormStatus status,
    @Default('') String error,
    UserProfileModel? model,
  }) = _UserProfileAccessFormState;
}



// class UserProfileAccessFormState {
//   final UserProfileAccessFormStatus userProfileAccessFormStatus;
//   final String error;
//   final UserProfileModel model;
// }
