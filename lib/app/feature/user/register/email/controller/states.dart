import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum UserRegisterEmailFormStatus { initial, loading, success, error }

@freezed
abstract class UserRegisterEmailFormState with _$UserRegisterEmailFormState {
  factory UserRegisterEmailFormState({
    @Default(UserRegisterEmailFormStatus.initial)
    UserRegisterEmailFormStatus status,
    @Default('') String error,
  }) = _UserRegisterEmailFormState;
}
