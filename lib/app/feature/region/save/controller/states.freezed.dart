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
mixin _$RegionFormState {
  RegionFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  RegionModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegionFormStateCopyWith<RegionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionFormStateCopyWith<$Res> {
  factory $RegionFormStateCopyWith(
          RegionFormState value, $Res Function(RegionFormState) then) =
      _$RegionFormStateCopyWithImpl<$Res, RegionFormState>;
  @useResult
  $Res call({RegionFormStatus status, String error, RegionModel? model});

  $RegionModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$RegionFormStateCopyWithImpl<$Res, $Val extends RegionFormState>
    implements $RegionFormStateCopyWith<$Res> {
  _$RegionFormStateCopyWithImpl(this._value, this._then);

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
              as RegionFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RegionModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $RegionModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RegionFormStateCopyWith<$Res>
    implements $RegionFormStateCopyWith<$Res> {
  factory _$$_RegionFormStateCopyWith(
          _$_RegionFormState value, $Res Function(_$_RegionFormState) then) =
      __$$_RegionFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RegionFormStatus status, String error, RegionModel? model});

  @override
  $RegionModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_RegionFormStateCopyWithImpl<$Res>
    extends _$RegionFormStateCopyWithImpl<$Res, _$_RegionFormState>
    implements _$$_RegionFormStateCopyWith<$Res> {
  __$$_RegionFormStateCopyWithImpl(
      _$_RegionFormState _value, $Res Function(_$_RegionFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_RegionFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RegionFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
    ));
  }
}

/// @nodoc

class _$_RegionFormState implements _RegionFormState {
  _$_RegionFormState(
      {this.status = RegionFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final RegionFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final RegionModel? model;

  @override
  String toString() {
    return 'RegionFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegionFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegionFormStateCopyWith<_$_RegionFormState> get copyWith =>
      __$$_RegionFormStateCopyWithImpl<_$_RegionFormState>(this, _$identity);
}

abstract class _RegionFormState implements RegionFormState {
  factory _RegionFormState(
      {final RegionFormStatus status,
      final String error,
      final RegionModel? model}) = _$_RegionFormState;

  @override
  RegionFormStatus get status;
  @override
  String get error;
  @override
  RegionModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_RegionFormStateCopyWith<_$_RegionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
