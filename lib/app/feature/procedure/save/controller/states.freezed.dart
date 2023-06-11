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
mixin _$ProcedureFormState {
  ProcedureFormStatus get status => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  ProcedureModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProcedureFormStateCopyWith<ProcedureFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureFormStateCopyWith<$Res> {
  factory $ProcedureFormStateCopyWith(
          ProcedureFormState value, $Res Function(ProcedureFormState) then) =
      _$ProcedureFormStateCopyWithImpl<$Res, ProcedureFormState>;
  @useResult
  $Res call({ProcedureFormStatus status, String error, ProcedureModel? model});

  $ProcedureModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$ProcedureFormStateCopyWithImpl<$Res, $Val extends ProcedureFormState>
    implements $ProcedureFormStateCopyWith<$Res> {
  _$ProcedureFormStateCopyWithImpl(this._value, this._then);

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
              as ProcedureFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ProcedureModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProcedureModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $ProcedureModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProcedureFormStateCopyWith<$Res>
    implements $ProcedureFormStateCopyWith<$Res> {
  factory _$$_ProcedureFormStateCopyWith(_$_ProcedureFormState value,
          $Res Function(_$_ProcedureFormState) then) =
      __$$_ProcedureFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProcedureFormStatus status, String error, ProcedureModel? model});

  @override
  $ProcedureModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_ProcedureFormStateCopyWithImpl<$Res>
    extends _$ProcedureFormStateCopyWithImpl<$Res, _$_ProcedureFormState>
    implements _$$_ProcedureFormStateCopyWith<$Res> {
  __$$_ProcedureFormStateCopyWithImpl(
      _$_ProcedureFormState _value, $Res Function(_$_ProcedureFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = null,
    Object? model = freezed,
  }) {
    return _then(_$_ProcedureFormState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProcedureFormStatus,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ProcedureModel?,
    ));
  }
}

/// @nodoc

class _$_ProcedureFormState implements _ProcedureFormState {
  _$_ProcedureFormState(
      {this.status = ProcedureFormStatus.initial, this.error = '', this.model});

  @override
  @JsonKey()
  final ProcedureFormStatus status;
  @override
  @JsonKey()
  final String error;
  @override
  final ProcedureModel? model;

  @override
  String toString() {
    return 'ProcedureFormState(status: $status, error: $error, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProcedureFormState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProcedureFormStateCopyWith<_$_ProcedureFormState> get copyWith =>
      __$$_ProcedureFormStateCopyWithImpl<_$_ProcedureFormState>(
          this, _$identity);
}

abstract class _ProcedureFormState implements ProcedureFormState {
  factory _ProcedureFormState(
      {final ProcedureFormStatus status,
      final String error,
      final ProcedureModel? model}) = _$_ProcedureFormState;

  @override
  ProcedureFormStatus get status;
  @override
  String get error;
  @override
  ProcedureModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_ProcedureFormStateCopyWith<_$_ProcedureFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
