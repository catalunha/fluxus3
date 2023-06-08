// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expertise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExpertiseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpertiseModelCopyWith<ExpertiseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpertiseModelCopyWith<$Res> {
  factory $ExpertiseModelCopyWith(
          ExpertiseModel value, $Res Function(ExpertiseModel) then) =
      _$ExpertiseModelCopyWithImpl<$Res, ExpertiseModel>;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$ExpertiseModelCopyWithImpl<$Res, $Val extends ExpertiseModel>
    implements $ExpertiseModelCopyWith<$Res> {
  _$ExpertiseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_ExpertiseModelCopyWith<$Res>
    implements $ExpertiseModelCopyWith<$Res> {
  factory _$$_ExpertiseModelCopyWith(
          _$_ExpertiseModel value, $Res Function(_$_ExpertiseModel) then) =
      __$$_ExpertiseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$_ExpertiseModelCopyWithImpl<$Res>
    extends _$ExpertiseModelCopyWithImpl<$Res, _$_ExpertiseModel>
    implements _$$_ExpertiseModelCopyWith<$Res> {
  __$$_ExpertiseModelCopyWithImpl(
      _$_ExpertiseModel _value, $Res Function(_$_ExpertiseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_ExpertiseModel(
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

class _$_ExpertiseModel implements _ExpertiseModel {
  _$_ExpertiseModel({this.id, this.name});

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'ExpertiseModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpertiseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpertiseModelCopyWith<_$_ExpertiseModel> get copyWith =>
      __$$_ExpertiseModelCopyWithImpl<_$_ExpertiseModel>(this, _$identity);
}

abstract class _ExpertiseModel implements ExpertiseModel {
  factory _ExpertiseModel({final String? id, final String? name}) =
      _$_ExpertiseModel;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_ExpertiseModelCopyWith<_$_ExpertiseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
