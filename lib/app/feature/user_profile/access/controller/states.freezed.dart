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
mixin _$UserProfileAccessFormState {
  UserProfileAccessFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  UserProfileModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileAccessFormStateCopyWith<UserProfileAccessFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileAccessFormStateCopyWith<$Res> {
  factory $UserProfileAccessFormStateCopyWith(UserProfileAccessFormState value,
          $Res Function(UserProfileAccessFormState) then) =
      _$UserProfileAccessFormStateCopyWithImpl<$Res,
          UserProfileAccessFormState>;
  @useResult
  $Res call(
      {UserProfileAccessFormStatus status,
      String error,
      UserProfileModel? model});

  $UserProfileModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$UserProfileAccessFormStateCopyWithImpl<$Res,
        $Val extends UserProfileAccessFormState>
    implements $UserProfileAccessFormStateCopyWith<$Res> {
  _$UserProfileAccessFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserProfileAccessFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $UserProfileModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserProfileAccessFormStateCopyWith<$Res>
    implements $UserProfileAccessFormStateCopyWith<$Res> {
  factory _$$_UserProfileAccessFormStateCopyWith(
          _$_UserProfileAccessFormState value,
          $Res Function(_$_UserProfileAccessFormState) then) =
      __$$_UserProfileAccessFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserProfileAccessFormStatus status,
      String error,
      UserProfileModel? model});

  @override
  $UserProfileModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_UserProfileAccessFormStateCopyWithImpl<$Res>
    extends _$UserProfileAccessFormStateCopyWithImpl<$Res,
        _$_UserProfileAccessFormState>
    implements _$$_UserProfileAccessFormStateCopyWith<$Res> {
  __$$_UserProfileAccessFormStateCopyWithImpl(
      _$_UserProfileAccessFormState _value,
      $Res Function(_$_UserProfileAccessFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_UserProfileAccessFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserProfileAccessFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
    ));
  }
}

/// @nodoc

class _$_UserProfileAccessFormState implements _UserProfileAccessFormState {
  _$_UserProfileAccessFormState(
      {this.status = UserProfileAccessFormStatus.initial,
      this.error = '',
      this.model});

  @override
  @JsonKey()
  final UserProfileAccessFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final UserProfileModel? model;

  @override
  String toString() {
    return 'UserProfileAccessFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProfileAccessFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProfileAccessFormStateCopyWith<_$_UserProfileAccessFormState>
      get copyWith => __$$_UserProfileAccessFormStateCopyWithImpl<
          _$_UserProfileAccessFormState>(this, _$identity);
}

abstract class _UserProfileAccessFormState
    implements UserProfileAccessFormState {
  factory _UserProfileAccessFormState(
      {final UserProfileAccessFormStatus status,
      final String error,
      final UserProfileModel? model}) = _$_UserProfileAccessFormState;

  @override
  UserProfileAccessFormStatus get status;
  @override
  String get error;
  @override
  UserProfileModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_UserProfileAccessFormStateCopyWith<_$_UserProfileAccessFormState>
      get copyWith => throw _privateConstructorUsedError;
}
