// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'office_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OfficeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OfficeModelCopyWith<OfficeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeModelCopyWith<$Res> {
  factory $OfficeModelCopyWith(
          OfficeModel value, $Res Function(OfficeModel) then) =
      _$OfficeModelCopyWithImpl<$Res, OfficeModel>;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$OfficeModelCopyWithImpl<$Res, $Val extends OfficeModel>
    implements $OfficeModelCopyWith<$Res> {
  _$OfficeModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_OfficeModelCopyWith<$Res>
    implements $OfficeModelCopyWith<$Res> {
  factory _$$_OfficeModelCopyWith(
          _$_OfficeModel value, $Res Function(_$_OfficeModel) then) =
      __$$_OfficeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$_OfficeModelCopyWithImpl<$Res>
    extends _$OfficeModelCopyWithImpl<$Res, _$_OfficeModel>
    implements _$$_OfficeModelCopyWith<$Res> {
  __$$_OfficeModelCopyWithImpl(
      _$_OfficeModel _value, $Res Function(_$_OfficeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_OfficeModel(
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

class _$_OfficeModel implements _OfficeModel {
  _$_OfficeModel({this.id, this.name});

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'OfficeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfficeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OfficeModelCopyWith<_$_OfficeModel> get copyWith =>
      __$$_OfficeModelCopyWithImpl<_$_OfficeModel>(this, _$identity);
}

abstract class _OfficeModel implements OfficeModel {
  factory _OfficeModel({final String? id, final String? name}) = _$_OfficeModel;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_OfficeModelCopyWith<_$_OfficeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
