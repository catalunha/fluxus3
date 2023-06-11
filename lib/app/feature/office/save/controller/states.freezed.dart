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
mixin _$OfficeFormState {
  OfficeFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  OfficeModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OfficeFormStateCopyWith<OfficeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeFormStateCopyWith<$Res> {
  factory $OfficeFormStateCopyWith(
          OfficeFormState value, $Res Function(OfficeFormState) then) =
      _$OfficeFormStateCopyWithImpl<$Res, OfficeFormState>;
  @useResult
  $Res call({OfficeFormStatus status, String error, OfficeModel? model});

  $OfficeModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$OfficeFormStateCopyWithImpl<$Res, $Val extends OfficeFormState>
    implements $OfficeFormStateCopyWith<$Res> {
  _$OfficeFormStateCopyWithImpl(this._value, this._then);

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
              as OfficeFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as OfficeModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OfficeModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $OfficeModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OfficeFormStateCopyWith<$Res>
    implements $OfficeFormStateCopyWith<$Res> {
  factory _$$_OfficeFormStateCopyWith(
          _$_OfficeFormState value, $Res Function(_$_OfficeFormState) then) =
      __$$_OfficeFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OfficeFormStatus status, String error, OfficeModel? model});

  @override
  $OfficeModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_OfficeFormStateCopyWithImpl<$Res>
    extends _$OfficeFormStateCopyWithImpl<$Res, _$_OfficeFormState>
    implements _$$_OfficeFormStateCopyWith<$Res> {
  __$$_OfficeFormStateCopyWithImpl(
      _$_OfficeFormState _value, $Res Function(_$_OfficeFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_OfficeFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OfficeFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as OfficeModel?,
    ));
  }
}

/// @nodoc

class _$_OfficeFormState implements _OfficeFormState {
  _$_OfficeFormState(
      {this.status = OfficeFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final OfficeFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final OfficeModel? model;

  @override
  String toString() {
    return 'OfficeFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfficeFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OfficeFormStateCopyWith<_$_OfficeFormState> get copyWith =>
      __$$_OfficeFormStateCopyWithImpl<_$_OfficeFormState>(this, _$identity);
}

abstract class _OfficeFormState implements OfficeFormState {
  factory _OfficeFormState(
      {final OfficeFormStatus status,
      final String error,
      final OfficeModel? model}) = _$_OfficeFormState;

  @override
  OfficeFormStatus get status;
  @override
  String get error;
  @override
  OfficeModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_OfficeFormStateCopyWith<_$_OfficeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
