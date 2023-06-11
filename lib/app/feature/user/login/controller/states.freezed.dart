// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserLoginFormState {
  UserLoginFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserLoginFormStateCopyWith<UserLoginFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginFormStateCopyWith<$Res> {
  factory $UserLoginFormStateCopyWith(
          UserLoginFormState value, $Res Function(UserLoginFormState) then) =
      _$UserLoginFormStateCopyWithImpl<$Res, UserLoginFormState>;
  @useResult
  $Res call({UserLoginFormStatus status, String error});
}

/// @nodoc
class _$UserLoginFormStateCopyWithImpl<$Res, $Val extends UserLoginFormState>
    implements $UserLoginFormStateCopyWith<$Res> {
  _$UserLoginFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserLoginFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserLoginFormStateCopyWith<$Res>
    implements $UserLoginFormStateCopyWith<$Res> {
  factory _$$_UserLoginFormStateCopyWith(_$_UserLoginFormState value,
          $Res Function(_$_UserLoginFormState) then) =
      __$$_UserLoginFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserLoginFormStatus status, String error});
}

/// @nodoc
class __$$_UserLoginFormStateCopyWithImpl<$Res>
    extends _$UserLoginFormStateCopyWithImpl<$Res, _$_UserLoginFormState>
    implements _$$_UserLoginFormStateCopyWith<$Res> {
  __$$_UserLoginFormStateCopyWithImpl(
      _$_UserLoginFormState _value, $Res Function(_$_UserLoginFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
  }) {
    return _then(_$_UserLoginFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserLoginFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserLoginFormState implements _UserLoginFormState {
  _$_UserLoginFormState(
      {this.status = UserLoginFormStatus.initial, this.error = ''});

  @override
  @JsonKey()
  final UserLoginFormStatus status;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'UserLoginFormState(status: $status, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserLoginFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserLoginFormStateCopyWith<_$_UserLoginFormState> get copyWith =>
      __$$_UserLoginFormStateCopyWithImpl<_$_UserLoginFormState>(
          this, _$identity);
}

abstract class _UserLoginFormState implements UserLoginFormState {
  factory _UserLoginFormState(
      {final UserLoginFormStatus status,
      final String error}) = _$_UserLoginFormState;

  @override
  UserLoginFormStatus get status;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$_UserLoginFormStateCopyWith<_$_UserLoginFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
