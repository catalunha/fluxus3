import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

// Status
enum UserLoginFormStatus { initial, loading, success, error }

@freezed
abstract class UserLoginFormState with _$UserLoginFormState {
  factory UserLoginFormState({
    @Default(UserLoginFormStatus.initial) UserLoginFormStatus status,
    @Default('') String error,
  }) = _UserLoginFormState;
}
