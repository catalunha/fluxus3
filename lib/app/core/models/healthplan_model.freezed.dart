// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'healthplan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HealthPlanModel {
  String? get id => throw _privateConstructorUsedError;
  HealthPlanTypeModel? get healthPlanType => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  DateTime? get due => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HealthPlanModelCopyWith<HealthPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthPlanModelCopyWith<$Res> {
  factory $HealthPlanModelCopyWith(
          HealthPlanModel value, $Res Function(HealthPlanModel) then) =
      _$HealthPlanModelCopyWithImpl<$Res, HealthPlanModel>;
  @useResult
  $Res call(
      {String? id,
      HealthPlanTypeModel? healthPlanType,
      String? code,
      DateTime? due,
      String? description});
}

/// @nodoc
class _$HealthPlanModelCopyWithImpl<$Res, $Val extends HealthPlanModel>
    implements $HealthPlanModelCopyWith<$Res> {
  _$HealthPlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? healthPlanType = freezed,
    Object? code = freezed,
    Object? due = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPlanType: freezed == healthPlanType
          ? _value.healthPlanType
          : healthPlanType // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeModel?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      due: freezed == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HealthPlanModelCopyWith<$Res>
    implements $HealthPlanModelCopyWith<$Res> {
  factory _$$_HealthPlanModelCopyWith(
          _$_HealthPlanModel value, $Res Function(_$_HealthPlanModel) then) =
      __$$_HealthPlanModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      HealthPlanTypeModel? healthPlanType,
      String? code,
      DateTime? due,
      String? description});
}

/// @nodoc
class __$$_HealthPlanModelCopyWithImpl<$Res>
    extends _$HealthPlanModelCopyWithImpl<$Res, _$_HealthPlanModel>
    implements _$$_HealthPlanModelCopyWith<$Res> {
  __$$_HealthPlanModelCopyWithImpl(
      _$_HealthPlanModel _value, $Res Function(_$_HealthPlanModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? healthPlanType = freezed,
    Object? code = freezed,
    Object? due = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_HealthPlanModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPlanType: freezed == healthPlanType
          ? _value.healthPlanType
          : healthPlanType // ignore: cast_nullable_to_non_nullable
              as HealthPlanTypeModel?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      due: freezed == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_HealthPlanModel implements _HealthPlanModel {
  _$_HealthPlanModel(
      {this.id, this.healthPlanType, this.code, this.due, this.description});

  @override
  final String? id;
  @override
  final HealthPlanTypeModel? healthPlanType;
  @override
  final String? code;
  @override
  final DateTime? due;
  @override
  final String? description;

  @override
  String toString() {
    return 'HealthPlanModel(id: $id, healthPlanType: $healthPlanType, code: $code, due: $due, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthPlanModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.healthPlanType, healthPlanType) ||
                other.healthPlanType == healthPlanType) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.due, due) || other.due == due) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, healthPlanType, code, due, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HealthPlanModelCopyWith<_$_HealthPlanModel> get copyWith =>
      __$$_HealthPlanModelCopyWithImpl<_$_HealthPlanModel>(this, _$identity);
}

abstract class _HealthPlanModel implements HealthPlanModel {
  factory _HealthPlanModel(
      {final String? id,
      final HealthPlanTypeModel? healthPlanType,
      final String? code,
      final DateTime? due,
      final String? description}) = _$_HealthPlanModel;

  @override
  String? get id;
  @override
  HealthPlanTypeModel? get healthPlanType;
  @override
  String? get code;
  @override
  DateTime? get due;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_HealthPlanModelCopyWith<_$_HealthPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}
