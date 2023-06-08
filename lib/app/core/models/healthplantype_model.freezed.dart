// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'healthplantype_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HealthPlanTypeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HealthPlanTypeModelCopyWith<HealthPlanTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthPlanTypeModelCopyWith<$Res> {
  factory $HealthPlanTypeModelCopyWith(
          HealthPlanTypeModel value, $Res Function(HealthPlanTypeModel) then) =
      _$HealthPlanTypeModelCopyWithImpl<$Res, HealthPlanTypeModel>;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$HealthPlanTypeModelCopyWithImpl<$Res, $Val extends HealthPlanTypeModel>
    implements $HealthPlanTypeModelCopyWith<$Res> {
  _$HealthPlanTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HealthPlanTypeModelCopyWith<$Res>
    implements $HealthPlanTypeModelCopyWith<$Res> {
  factory _$$_HealthPlanTypeModelCopyWith(_$_HealthPlanTypeModel value,
          $Res Function(_$_HealthPlanTypeModel) then) =
      __$$_HealthPlanTypeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$_HealthPlanTypeModelCopyWithImpl<$Res>
    extends _$HealthPlanTypeModelCopyWithImpl<$Res, _$_HealthPlanTypeModel>
    implements _$$_HealthPlanTypeModelCopyWith<$Res> {
  __$$_HealthPlanTypeModelCopyWithImpl(_$_HealthPlanTypeModel _value,
      $Res Function(_$_HealthPlanTypeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_HealthPlanTypeModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_HealthPlanTypeModel implements _HealthPlanTypeModel {
  _$_HealthPlanTypeModel({this.id, this.name});

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'HealthPlanTypeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthPlanTypeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HealthPlanTypeModelCopyWith<_$_HealthPlanTypeModel> get copyWith =>
      __$$_HealthPlanTypeModelCopyWithImpl<_$_HealthPlanTypeModel>(
          this, _$identity);
}

abstract class _HealthPlanTypeModel implements HealthPlanTypeModel {
  factory _HealthPlanTypeModel({final String? id, final String? name}) =
      _$_HealthPlanTypeModel;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_HealthPlanTypeModelCopyWith<_$_HealthPlanTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
