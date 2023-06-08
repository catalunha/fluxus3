// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProcedureModel {
  String? get id => throw _privateConstructorUsedError;
  ExpertiseModel? get expertise => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  double? get cost => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProcedureModelCopyWith<ProcedureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureModelCopyWith<$Res> {
  factory $ProcedureModelCopyWith(
          ProcedureModel value, $Res Function(ProcedureModel) then) =
      _$ProcedureModelCopyWithImpl<$Res, ProcedureModel>;
  @useResult
  $Res call(
      {String? id,
      ExpertiseModel? expertise,
      String? code,
      String? name,
      double? cost});

  $ExpertiseModelCopyWith<$Res>? get expertise;
}

/// @nodoc
class _$ProcedureModelCopyWithImpl<$Res, $Val extends ProcedureModel>
    implements $ProcedureModelCopyWith<$Res> {
  _$ProcedureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? expertise = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? cost = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as ExpertiseModel?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExpertiseModelCopyWith<$Res>? get expertise {
    if (_value.expertise == null) {
      return null;
    }

    return $ExpertiseModelCopyWith<$Res>(_value.expertise!, (value) {
      return _then(_value.copyWith(expertise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProcedureModelCopyWith<$Res>
    implements $ProcedureModelCopyWith<$Res> {
  factory _$$_ProcedureModelCopyWith(
          _$_ProcedureModel value, $Res Function(_$_ProcedureModel) then) =
      __$$_ProcedureModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      ExpertiseModel? expertise,
      String? code,
      String? name,
      double? cost});

  @override
  $ExpertiseModelCopyWith<$Res>? get expertise;
}

/// @nodoc
class __$$_ProcedureModelCopyWithImpl<$Res>
    extends _$ProcedureModelCopyWithImpl<$Res, _$_ProcedureModel>
    implements _$$_ProcedureModelCopyWith<$Res> {
  __$$_ProcedureModelCopyWithImpl(
      _$_ProcedureModel _value, $Res Function(_$_ProcedureModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? expertise = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? cost = freezed,
  }) {
    return _then(_$_ProcedureModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as ExpertiseModel?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_ProcedureModel implements _ProcedureModel {
  _$_ProcedureModel({this.id, this.expertise, this.code, this.name, this.cost});

  @override
  final String? id;
  @override
  final ExpertiseModel? expertise;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final double? cost;

  @override
  String toString() {
    return 'ProcedureModel(id: $id, expertise: $expertise, code: $code, name: $name, cost: $cost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProcedureModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expertise, expertise) ||
                other.expertise == expertise) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, expertise, code, name, cost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProcedureModelCopyWith<_$_ProcedureModel> get copyWith =>
      __$$_ProcedureModelCopyWithImpl<_$_ProcedureModel>(this, _$identity);
}

abstract class _ProcedureModel implements ProcedureModel {
  factory _ProcedureModel(
      {final String? id,
      final ExpertiseModel? expertise,
      final String? code,
      final String? name,
      final double? cost}) = _$_ProcedureModel;

  @override
  String? get id;
  @override
  ExpertiseModel? get expertise;
  @override
  String? get code;
  @override
  String? get name;
  @override
  double? get cost;
  @override
  @JsonKey(ignore: true)
  _$$_ProcedureModelCopyWith<_$_ProcedureModel> get copyWith =>
      throw _privateConstructorUsedError;
}
