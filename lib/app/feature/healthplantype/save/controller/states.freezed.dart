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
mixin _$HealthPlanTypeFormState {
  HealthPlanTypeFormHealthPlanType get healthPlanType =>
      throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  HealthPlanTypeModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HealthPlanTypeFormStateCopyWith<HealthPlanTypeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthPlanTypeFormStateCopyWith<$Res> {
  factory $HealthPlanTypeFormStateCopyWith(HealthPlanTypeFormState value,
          $Res Function(HealthPlanTypeFormState) then) =
      _$HealthPlanTypeFormStateCopyWithImpl<$Res, HealthPlanTypeFormState>;
  @useResult
  $Res call(
      {HealthPlanTypeFormHealthPlanType healthPlanType,
      String error,
      HealthPlanTypeModel? model});

  $HealthPlanTypeModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$HealthPlanTypeFormStateCopyWithImpl<$Res,
        $Val extends HealthPlanTypeFormState>
    implements $HealthPlanTypeFormStateCopyWith<$Res> {
  _$HealthPlanTypeFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthPlanType = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      healthPlanType: null == healthPlanType
          ? _value.healthPlanType
          : healthPlanType // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeFormHealthPlanType,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthPlanTypeModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $HealthPlanTypeModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_HealthPlanTypeFormStateCopyWith<$Res>
    implements $HealthPlanTypeFormStateCopyWith<$Res> {
  factory _$$_HealthPlanTypeFormStateCopyWith(_$_HealthPlanTypeFormState value,
          $Res Function(_$_HealthPlanTypeFormState) then) =
      __$$_HealthPlanTypeFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HealthPlanTypeFormHealthPlanType healthPlanType,
      String error,
      HealthPlanTypeModel? model});

  @override
  $HealthPlanTypeModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_HealthPlanTypeFormStateCopyWithImpl<$Res>
    extends _$HealthPlanTypeFormStateCopyWithImpl<$Res,
        _$_HealthPlanTypeFormState>
    implements _$$_HealthPlanTypeFormStateCopyWith<$Res> {
  __$$_HealthPlanTypeFormStateCopyWithImpl(_$_HealthPlanTypeFormState _value,
      $Res Function(_$_HealthPlanTypeFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthPlanType = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_HealthPlanTypeFormState(
      healthPlanType: null == healthPlanType
          ? _value.healthPlanType
          : healthPlanType // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeFormHealthPlanType,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeModel?,
    ));
  }
}

/// @nodoc

class _$_HealthPlanTypeFormState implements _HealthPlanTypeFormState {
  _$_HealthPlanTypeFormState(
      {this.healthPlanType = HealthPlanTypeFormHealthPlanType.initial,
      this.error = '',
      this.model});

  @override
  @JsonKey()
  final HealthPlanTypeFormHealthPlanType healthPlanType;
  @override
  @JsonKey()
  final String error;
  @override
  final HealthPlanTypeModel? model;

  @override
  String toString() {
    return 'HealthPlanTypeFormState(healthPlanType: $healthPlanType, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthPlanTypeFormState &&
            (identical(other.healthPlanType, healthPlanType) ||
                other.healthPlanType == healthPlanType) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, healthPlanType, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HealthPlanTypeFormStateCopyWith<_$_HealthPlanTypeFormState>
      get copyWith =>
          __$$_HealthPlanTypeFormStateCopyWithImpl<_$_HealthPlanTypeFormState>(
              this, _$identity);
}

abstract class _HealthPlanTypeFormState implements HealthPlanTypeFormState {
  factory _HealthPlanTypeFormState(
      {final HealthPlanTypeFormHealthPlanType healthPlanType,
      final String error,
      final HealthPlanTypeModel? model}) = _$_HealthPlanTypeFormState;

  @override
  HealthPlanTypeFormHealthPlanType get healthPlanType;
  @override
  String get error;
  @override
  HealthPlanTypeModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_HealthPlanTypeFormStateCopyWith<_$_HealthPlanTypeFormState>
      get copyWith => throw _privateConstructorUsedError;
}
