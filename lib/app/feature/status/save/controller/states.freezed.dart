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
mixin _$StatusFormState {
  StatusFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  StatusModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatusFormStateCopyWith<StatusFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusFormStateCopyWith<$Res> {
  factory $StatusFormStateCopyWith(
          StatusFormState value, $Res Function(StatusFormState) then) =
      _$StatusFormStateCopyWithImpl<$Res, StatusFormState>;
  @useResult
  $Res call({StatusFormStatus status, String error, StatusModel? model});

  $StatusModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$StatusFormStateCopyWithImpl<$Res, $Val extends StatusFormState>
    implements $StatusFormStateCopyWith<$Res> {
  _$StatusFormStateCopyWithImpl(this._value, this._then);

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
              as StatusFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $StatusModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StatusFormStateCopyWith<$Res>
    implements $StatusFormStateCopyWith<$Res> {
  factory _$$_StatusFormStateCopyWith(
          _$_StatusFormState value, $Res Function(_$_StatusFormState) then) =
      __$$_StatusFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatusFormStatus status, String error, StatusModel? model});

  @override
  $StatusModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_StatusFormStateCopyWithImpl<$Res>
    extends _$StatusFormStateCopyWithImpl<$Res, _$_StatusFormState>
    implements _$$_StatusFormStateCopyWith<$Res> {
  __$$_StatusFormStateCopyWithImpl(
      _$_StatusFormState _value, $Res Function(_$_StatusFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_StatusFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
    ));
  }
}

/// @nodoc

class _$_StatusFormState implements _StatusFormState {
  _$_StatusFormState(
      {this.status = StatusFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final StatusFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final StatusModel? model;

  @override
  String toString() {
    return 'StatusFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatusFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatusFormStateCopyWith<_$_StatusFormState> get copyWith =>
      __$$_StatusFormStateCopyWithImpl<_$_StatusFormState>(this, _$identity);
}

abstract class _StatusFormState implements StatusFormState {
  factory _StatusFormState(
      {final StatusFormStatus status,
      final String error,
      final StatusModel? model}) = _$_StatusFormState;

  @override
  StatusFormStatus get status;
  @override
  String get error;
  @override
  StatusModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_StatusFormStateCopyWith<_$_StatusFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
