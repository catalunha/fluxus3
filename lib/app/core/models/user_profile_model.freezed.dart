// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<String> get access =>
      throw _privateConstructorUsedError; //admin, sec, prof, fin
  String? get nickname => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get cpf => throw _privateConstructorUsedError;
  String? get register =>
      throw _privateConstructorUsedError; // conselho de saude
  String? get phone => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  bool? get isFemale => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  RegionModel? get region => throw _privateConstructorUsedError;
  List<OfficeModel>? get offices =>
      throw _privateConstructorUsedError; // cargos
  List<ExpertiseModel>? get expertises =>
      throw _privateConstructorUsedError; // especialidade
  List<ProcedureModel>? get procedures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {String id,
      String userName,
      String email,
      bool isActive,
      List<String> access,
      String? nickname,
      String? name,
      String? cpf,
      String? register,
      String? phone,
      String? photo,
      bool? isFemale,
      DateTime? birthday,
      String? address,
      RegionModel? region,
      List<OfficeModel>? offices,
      List<ExpertiseModel>? expertises,
      List<ProcedureModel>? procedures});

  $RegionModelCopyWith<$Res>? get region;
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? email = null,
    Object? isActive = null,
    Object? access = null,
    Object? nickname = freezed,
    Object? name = freezed,
    Object? cpf = freezed,
    Object? register = freezed,
    Object? phone = freezed,
    Object? photo = freezed,
    Object? isFemale = freezed,
    Object? birthday = freezed,
    Object? address = freezed,
    Object? region = freezed,
    Object? offices = freezed,
    Object? expertises = freezed,
    Object? procedures = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cpf: freezed == cpf
          ? _value.cpf
          : cpf // ignore: cast_nullable_to_non_nullable
              as String?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isFemale: freezed == isFemale
          ? _value.isFemale
          : isFemale // ignore: cast_nullable_to_non_nullable
              as bool?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
      offices: freezed == offices
          ? _value.offices
          : offices // ignore: cast_nullable_to_non_nullable
              as List<OfficeModel>?,
      expertises: freezed == expertises
          ? _value.expertises
          : expertises // ignore: cast_nullable_to_non_nullable
              as List<ExpertiseModel>?,
      procedures: freezed == procedures
          ? _value.procedures
          : procedures // ignore: cast_nullable_to_non_nullable
              as List<ProcedureModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RegionModelCopyWith<$Res>? get region {
    if (_value.region == null) {
      return null;
    }

    return $RegionModelCopyWith<$Res>(_value.region!, (value) {
      return _then(_value.copyWith(region: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserProfileModelCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$_UserProfileModelCopyWith(
          _$_UserProfileModel value, $Res Function(_$_UserProfileModel) then) =
      __$$_UserProfileModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userName,
      String email,
      bool isActive,
      List<String> access,
      String? nickname,
      String? name,
      String? cpf,
      String? register,
      String? phone,
      String? photo,
      bool? isFemale,
      DateTime? birthday,
      String? address,
      RegionModel? region,
      List<OfficeModel>? offices,
      List<ExpertiseModel>? expertises,
      List<ProcedureModel>? procedures});

  @override
  $RegionModelCopyWith<$Res>? get region;
}

/// @nodoc
class __$$_UserProfileModelCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$_UserProfileModel>
    implements _$$_UserProfileModelCopyWith<$Res> {
  __$$_UserProfileModelCopyWithImpl(
      _$_UserProfileModel _value, $Res Function(_$_UserProfileModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? email = null,
    Object? isActive = null,
    Object? access = null,
    Object? nickname = freezed,
    Object? name = freezed,
    Object? cpf = freezed,
    Object? register = freezed,
    Object? phone = freezed,
    Object? photo = freezed,
    Object? isFemale = freezed,
    Object? birthday = freezed,
    Object? address = freezed,
    Object? region = freezed,
    Object? offices = freezed,
    Object? expertises = freezed,
    Object? procedures = freezed,
  }) {
    return _then(_$_UserProfileModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      access: null == access
          ? _value._access
          : access // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cpf: freezed == cpf
          ? _value.cpf
          : cpf // ignore: cast_nullable_to_non_nullable
              as String?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isFemale: freezed == isFemale
          ? _value.isFemale
          : isFemale // ignore: cast_nullable_to_non_nullable
              as bool?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
      offices: freezed == offices
          ? _value._offices
          : offices // ignore: cast_nullable_to_non_nullable
              as List<OfficeModel>?,
      expertises: freezed == expertises
          ? _value._expertises
          : expertises // ignore: cast_nullable_to_non_nullable
              as List<ExpertiseModel>?,
      procedures: freezed == procedures
          ? _value._procedures
          : procedures // ignore: cast_nullable_to_non_nullable
              as List<ProcedureModel>?,
    ));
  }
}

/// @nodoc

class _$_UserProfileModel implements _UserProfileModel {
  _$_UserProfileModel(
      {required this.id,
      required this.userName,
      required this.email,
      required this.isActive,
      required final List<String> access,
      this.nickname,
      this.name,
      this.cpf,
      this.register,
      this.phone,
      this.photo,
      this.isFemale,
      this.birthday,
      this.address,
      this.region,
      final List<OfficeModel>? offices,
      final List<ExpertiseModel>? expertises,
      final List<ProcedureModel>? procedures})
      : _access = access,
        _offices = offices,
        _expertises = expertises,
        _procedures = procedures;

  @override
  final String id;
  @override
  final String userName;
  @override
  final String email;
  @override
  final bool isActive;
  final List<String> _access;
  @override
  List<String> get access {
    if (_access is EqualUnmodifiableListView) return _access;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_access);
  }

//admin, sec, prof, fin
  @override
  final String? nickname;
  @override
  final String? name;
  @override
  final String? cpf;
  @override
  final String? register;
// conselho de saude
  @override
  final String? phone;
  @override
  final String? photo;
  @override
  final bool? isFemale;
  @override
  final DateTime? birthday;
  @override
  final String? address;
  @override
  final RegionModel? region;
  final List<OfficeModel>? _offices;
  @override
  List<OfficeModel>? get offices {
    final value = _offices;
    if (value == null) return null;
    if (_offices is EqualUnmodifiableListView) return _offices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// cargos
  final List<ExpertiseModel>? _expertises;
// cargos
  @override
  List<ExpertiseModel>? get expertises {
    final value = _expertises;
    if (value == null) return null;
    if (_expertises is EqualUnmodifiableListView) return _expertises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// especialidade
  final List<ProcedureModel>? _procedures;
// especialidade
  @override
  List<ProcedureModel>? get procedures {
    final value = _procedures;
    if (value == null) return null;
    if (_procedures is EqualUnmodifiableListView) return _procedures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserProfileModel(id: $id, userName: $userName, email: $email, isActive: $isActive, access: $access, nickname: $nickname, name: $name, cpf: $cpf, register: $register, phone: $phone, photo: $photo, isFemale: $isFemale, birthday: $birthday, address: $address, region: $region, offices: $offices, expertises: $expertises, procedures: $procedures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProfileModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._access, _access) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cpf, cpf) || other.cpf == cpf) &&
            (identical(other.register, register) ||
                other.register == register) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.isFemale, isFemale) ||
                other.isFemale == isFemale) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other._offices, _offices) &&
            const DeepCollectionEquality()
                .equals(other._expertises, _expertises) &&
            const DeepCollectionEquality()
                .equals(other._procedures, _procedures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userName,
      email,
      isActive,
      const DeepCollectionEquality().hash(_access),
      nickname,
      name,
      cpf,
      register,
      phone,
      photo,
      isFemale,
      birthday,
      address,
      region,
      const DeepCollectionEquality().hash(_offices),
      const DeepCollectionEquality().hash(_expertises),
      const DeepCollectionEquality().hash(_procedures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProfileModelCopyWith<_$_UserProfileModel> get copyWith =>
      __$$_UserProfileModelCopyWithImpl<_$_UserProfileModel>(this, _$identity);
}

abstract class _UserProfileModel implements UserProfileModel {
  factory _UserProfileModel(
      {required final String id,
      required final String userName,
      required final String email,
      required final bool isActive,
      required final List<String> access,
      final String? nickname,
      final String? name,
      final String? cpf,
      final String? register,
      final String? phone,
      final String? photo,
      final bool? isFemale,
      final DateTime? birthday,
      final String? address,
      final RegionModel? region,
      final List<OfficeModel>? offices,
      final List<ExpertiseModel>? expertises,
      final List<ProcedureModel>? procedures}) = _$_UserProfileModel;

  @override
  String get id;
  @override
  String get userName;
  @override
  String get email;
  @override
  bool get isActive;
  @override
  List<String> get access;
  @override //admin, sec, prof, fin
  String? get nickname;
  @override
  String? get name;
  @override
  String? get cpf;
  @override
  String? get register;
  @override // conselho de saude
  String? get phone;
  @override
  String? get photo;
  @override
  bool? get isFemale;
  @override
  DateTime? get birthday;
  @override
  String? get address;
  @override
  RegionModel? get region;
  @override
  List<OfficeModel>? get offices;
  @override // cargos
  List<ExpertiseModel>? get expertises;
  @override // especialidade
  List<ProcedureModel>? get procedures;
  @override
  @JsonKey(ignore: true)
  _$$_UserProfileModelCopyWith<_$_UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}
