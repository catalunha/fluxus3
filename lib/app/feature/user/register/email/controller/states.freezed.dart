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
mixin _$UserRegisterEmailFormState {
  UserRegisterEmailFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserRegisterEmailFormStateCopyWith<UserRegisterEmailFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRegisterEmailFormStateCopyWith<$Res> {
  factory $UserRegisterEmailFormStateCopyWith(UserRegisterEmailFormState value,
          $Res Function(UserRegisterEmailFormState) then) =
      _$UserRegisterEmailFormStateCopyWithImpl<$Res,
          UserRegisterEmailFormState>;
  @useResult
  $Res call({UserRegisterEmailFormStatus status, String error});
}

/// @nodoc
class _$UserRegisterEmailFormStateCopyWithImpl<$Res,
        $Val extends UserRegisterEmailFormState>
    implements $UserRegisterEmailFormStateCopyWith<$Res> {
  _$UserRegisterEmailFormStateCopyWithImpl(this._value, this._then);

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
              as UserRegisterEmailFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserRegisterEmailFormStateCopyWith<$Res>
    implements $UserRegisterEmailFormStateCopyWith<$Res> {
  factory _$$_UserRegisterEmailFormStateCopyWith(
          _$_UserRegisterEmailFormState value,
          $Res Function(_$_UserRegisterEmailFormState) then) =
      __$$_UserRegisterEmailFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserRegisterEmailFormStatus status, String error});
}

/// @nodoc
class __$$_UserRegisterEmailFormStateCopyWithImpl<$Res>
    extends _$UserRegisterEmailFormStateCopyWithImpl<$Res,
        _$_UserRegisterEmailFormState>
    implements _$$_UserRegisterEmailFormStateCopyWith<$Res> {
  __$$_UserRegisterEmailFormStateCopyWithImpl(
      _$_UserRegisterEmailFormState _value,
      $Res Function(_$_UserRegisterEmailFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
  }) {
    return _then(_$_UserRegisterEmailFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserRegisterEmailFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserRegisterEmailFormState implements _UserRegisterEmailFormState {
  _$_UserRegisterEmailFormState(
      {this.status = UserRegisterEmailFormStatus.initial, this.error = ''});

  @override
  @JsonKey()
  final UserRegisterEmailFormStatus status;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'UserRegisterEmailFormState(status: $status, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserRegisterEmailFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserRegisterEmailFormStateCopyWith<_$_UserRegisterEmailFormState>
      get copyWith => __$$_UserRegisterEmailFormStateCopyWithImpl<
          _$_UserRegisterEmailFormState>(this, _$identity);
}

abstract class _UserRegisterEmailFormState
    implements UserRegisterEmailFormState {
  factory _UserRegisterEmailFormState(
      {final UserRegisterEmailFormStatus status,
      final String error}) = _$_UserRegisterEmailFormState;

  @override
  UserRegisterEmailFormStatus get status;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$_UserRegisterEmailFormStateCopyWith<_$_UserRegisterEmailFormState>
      get copyWith => throw _privateConstructorUsedError;
}
