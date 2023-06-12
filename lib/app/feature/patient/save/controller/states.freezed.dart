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
mixin _$PatientFormState {
  PatientFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  PatientModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PatientFormStateCopyWith<PatientFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientFormStateCopyWith<$Res> {
  factory $PatientFormStateCopyWith(
          PatientFormState value, $Res Function(PatientFormState) then) =
      _$PatientFormStateCopyWithImpl<$Res, PatientFormState>;
  @useResult
  $Res call({PatientFormStatus status, String error, PatientModel? model});

  $PatientModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$PatientFormStateCopyWithImpl<$Res, $Val extends PatientFormState>
    implements $PatientFormStateCopyWith<$Res> {
  _$PatientFormStateCopyWithImpl(this._value, this._then);

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
              as PatientFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as PatientModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PatientModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $PatientModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PatientFormStateCopyWith<$Res>
    implements $PatientFormStateCopyWith<$Res> {
  factory _$$_PatientFormStateCopyWith(
          _$_PatientFormState value, $Res Function(_$_PatientFormState) then) =
      __$$_PatientFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PatientFormStatus status, String error, PatientModel? model});

  @override
  $PatientModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_PatientFormStateCopyWithImpl<$Res>
    extends _$PatientFormStateCopyWithImpl<$Res, _$_PatientFormState>
    implements _$$_PatientFormStateCopyWith<$Res> {
  __$$_PatientFormStateCopyWithImpl(
      _$_PatientFormState _value, $Res Function(_$_PatientFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_PatientFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PatientFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as PatientModel?,
    ));
  }
}

/// @nodoc

class _$_PatientFormState implements _PatientFormState {
  _$_PatientFormState(
      {this.status = PatientFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final PatientFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final PatientModel? model;

  @override
  String toString() {
    return 'PatientFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PatientFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PatientFormStateCopyWith<_$_PatientFormState> get copyWith =>
      __$$_PatientFormStateCopyWithImpl<_$_PatientFormState>(this, _$identity);
}

abstract class _PatientFormState implements PatientFormState {
  factory _PatientFormState(
      {final PatientFormStatus status,
      final String error,
      final PatientModel? model}) = _$_PatientFormState;

  @override
  PatientFormStatus get status;
  @override
  String get error;
  @override
  PatientModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_PatientFormStateCopyWith<_$_PatientFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
