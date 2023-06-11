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
mixin _$RoomFormState {
  RoomFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  RoomModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomFormStateCopyWith<RoomFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomFormStateCopyWith<$Res> {
  factory $RoomFormStateCopyWith(
          RoomFormState value, $Res Function(RoomFormState) then) =
      _$RoomFormStateCopyWithImpl<$Res, RoomFormState>;
  @useResult
  $Res call({RoomFormStatus status, String error, RoomModel? model});

  $RoomModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$RoomFormStateCopyWithImpl<$Res, $Val extends RoomFormState>
    implements $RoomFormStateCopyWith<$Res> {
  _$RoomFormStateCopyWithImpl(this._value, this._then);

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
              as RoomFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RoomModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $RoomModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RoomFormStateCopyWith<$Res>
    implements $RoomFormStateCopyWith<$Res> {
  factory _$$_RoomFormStateCopyWith(
          _$_RoomFormState value, $Res Function(_$_RoomFormState) then) =
      __$$_RoomFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RoomFormStatus status, String error, RoomModel? model});

  @override
  $RoomModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_RoomFormStateCopyWithImpl<$Res>
    extends _$RoomFormStateCopyWithImpl<$Res, _$_RoomFormState>
    implements _$$_RoomFormStateCopyWith<$Res> {
  __$$_RoomFormStateCopyWithImpl(
      _$_RoomFormState _value, $Res Function(_$_RoomFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_RoomFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RoomFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
    ));
  }
}

/// @nodoc

class _$_RoomFormState implements _RoomFormState {
  _$_RoomFormState(
      {this.status = RoomFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final RoomFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final RoomModel? model;

  @override
  String toString() {
    return 'RoomFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomFormStateCopyWith<_$_RoomFormState> get copyWith =>
      __$$_RoomFormStateCopyWithImpl<_$_RoomFormState>(this, _$identity);
}

abstract class _RoomFormState implements RoomFormState {
  factory _RoomFormState(
      {final RoomFormStatus status,
      final String error,
      final RoomModel? model}) = _$_RoomFormState;

  @override
  RoomFormStatus get status;
  @override
  String get error;
  @override
  RoomModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_RoomFormStateCopyWith<_$_RoomFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
