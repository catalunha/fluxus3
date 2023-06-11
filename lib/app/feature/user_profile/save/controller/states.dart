import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/user_profile_model.dart';

part 'states.freezed.dart';

enum UserProfileSaveFormStatus { initial, loading, success, error }

@freezed
abstract class UserProfileSaveFormState with _$UserProfileSaveFormState {
  factory UserProfileSaveFormState({
    @Default(UserProfileSaveFormStatus.initial)
    UserProfileSaveFormStatus status,
    @Default('') String error,
    UserProfileModel? model,
  }) = _UserProfileSaveFormState;
}
