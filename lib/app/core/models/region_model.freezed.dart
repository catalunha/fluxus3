// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegionModel {
  String? get id => throw _privateConstructorUsedError;
  String? get uf => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegionModelCopyWith<RegionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionModelCopyWith<$Res> {
  factory $RegionModelCopyWith(
          RegionModel value, $Res Function(RegionModel) then) =
      _$RegionModelCopyWithImpl<$Res, RegionModel>;
  @useResult
  $Res call({String? id, String? uf, String? city, String? name});
}

/// @nodoc
class _$RegionModelCopyWithImpl<$Res, $Val extends RegionModel>
    implements $RegionModelCopyWith<$Res> {
  _$RegionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uf = freezed,
    Object? city = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uf: freezed == uf
          ? _value.uf
          : uf // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegionModelCopyWith<$Res>
    implements $RegionModelCopyWith<$Res> {
  factory _$$_RegionModelCopyWith(
          _$_RegionModel value, $Res Function(_$_RegionModel) then) =
      __$$_RegionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? uf, String? city, String? name});
}

/// @nodoc
class __$$_RegionModelCopyWithImpl<$Res>
    extends _$RegionModelCopyWithImpl<$Res, _$_RegionModel>
    implements _$$_RegionModelCopyWith<$Res> {
  __$$_RegionModelCopyWithImpl(
      _$_RegionModel _value, $Res Function(_$_RegionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uf = freezed,
    Object? city = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_RegionModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uf: freezed == uf
          ? _value.uf
          : uf // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RegionModel implements _RegionModel {
  _$_RegionModel({this.id, this.uf, this.city, this.name});

  @override
  final String? id;
  @override
  final String? uf;
  @override
  final String? city;
  @override
  final String? name;

  @override
  String toString() {
    return 'RegionModel(id: $id, uf: $uf, city: $city, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uf, uf) || other.uf == uf) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, uf, city, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegionModelCopyWith<_$_RegionModel> get copyWith =>
      __$$_RegionModelCopyWithImpl<_$_RegionModel>(this, _$identity);
}

abstract class _RegionModel implements RegionModel {
  factory _RegionModel(
      {final String? id,
      final String? uf,
      final String? city,
      final String? name}) = _$_RegionModel;

  @override
  String? get id;
  @override
  String? get uf;
  @override
  String? get city;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_RegionModelCopyWith<_$_RegionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
