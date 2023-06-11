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
mixin _$ExpertiseFormState {
  ExpertiseFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  ExpertiseModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpertiseFormStateCopyWith<ExpertiseFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpertiseFormStateCopyWith<$Res> {
  factory $ExpertiseFormStateCopyWith(
          ExpertiseFormState value, $Res Function(ExpertiseFormState) then) =
      _$ExpertiseFormStateCopyWithImpl<$Res, ExpertiseFormState>;
  @useResult
  $Res call({ExpertiseFormStatus status, String error, ExpertiseModel? model});

  $ExpertiseModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$ExpertiseFormStateCopyWithImpl<$Res, $Val extends ExpertiseFormState>
    implements $ExpertiseFormStateCopyWith<$Res> {
  _$ExpertiseFormStateCopyWithImpl(this._value, this._then);

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
              as ExpertiseFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ExpertiseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExpertiseModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $ExpertiseModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ExpertiseFormStateCopyWith<$Res>
    implements $ExpertiseFormStateCopyWith<$Res> {
  factory _$$_ExpertiseFormStateCopyWith(_$_ExpertiseFormState value,
          $Res Function(_$_ExpertiseFormState) then) =
      __$$_ExpertiseFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExpertiseFormStatus status, String error, ExpertiseModel? model});

  @override
  $ExpertiseModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_ExpertiseFormStateCopyWithImpl<$Res>
    extends _$ExpertiseFormStateCopyWithImpl<$Res, _$_ExpertiseFormState>
    implements _$$_ExpertiseFormStateCopyWith<$Res> {
  __$$_ExpertiseFormStateCopyWithImpl(
      _$_ExpertiseFormState _value, $Res Function(_$_ExpertiseFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_ExpertiseFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExpertiseFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ExpertiseModel?,
    ));
  }
}

/// @nodoc

class _$_ExpertiseFormState implements _ExpertiseFormState {
  _$_ExpertiseFormState(
      {this.status = ExpertiseFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final ExpertiseFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final ExpertiseModel? model;

  @override
  String toString() {
    return 'ExpertiseFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpertiseFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpertiseFormStateCopyWith<_$_ExpertiseFormState> get copyWith =>
      __$$_ExpertiseFormStateCopyWithImpl<_$_ExpertiseFormState>(
          this, _$identity);
}

abstract class _ExpertiseFormState implements ExpertiseFormState {
  factory _ExpertiseFormState(
      {final ExpertiseFormStatus status,
      final String error,
      final ExpertiseModel? model}) = _$_ExpertiseFormState;

  @override
  ExpertiseFormStatus get status;
  @override
  String get error;
  @override
  ExpertiseModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_ExpertiseFormStateCopyWith<_$_ExpertiseFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
