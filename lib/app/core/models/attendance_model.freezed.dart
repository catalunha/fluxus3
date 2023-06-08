// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AttendanceModel {
  String? get id => throw _privateConstructorUsedError;
  UserProfileModel? get professional => throw _privateConstructorUsedError;
  ProcedureModel? get procedure => throw _privateConstructorUsedError;
  PatientModel? get patient => throw _privateConstructorUsedError;
  HealthPlanModel? get healthPlan => throw _privateConstructorUsedError;
  String? get authorizationCode => throw _privateConstructorUsedError;
  DateTime? get authorizationDateCreated => throw _privateConstructorUsedError;
  DateTime? get authorizationDateLimit => throw _privateConstructorUsedError;
  DateTime? get attendance => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get confirmedPresence => throw _privateConstructorUsedError;
  StatusModel? get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttendanceModelCopyWith<AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceModelCopyWith<$Res> {
  factory $AttendanceModelCopyWith(
          AttendanceModel value, $Res Function(AttendanceModel) then) =
      _$AttendanceModelCopyWithImpl<$Res, AttendanceModel>;
  @useResult
  $Res call(
      {String? id,
      UserProfileModel? professional,
      ProcedureModel? procedure,
      PatientModel? patient,
      HealthPlanModel? healthPlan,
      String? authorizationCode,
      DateTime? authorizationDateCreated,
      DateTime? authorizationDateLimit,
      DateTime? attendance,
      String? description,
      DateTime? confirmedPresence,
      StatusModel? status});

  $UserProfileModelCopyWith<$Res>? get professional;
  $ProcedureModelCopyWith<$Res>? get procedure;
  $PatientModelCopyWith<$Res>? get patient;
  $HealthPlanModelCopyWith<$Res>? get healthPlan;
  $StatusModelCopyWith<$Res>? get status;
}

/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res, $Val extends AttendanceModel>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? professional = freezed,
    Object? procedure = freezed,
    Object? patient = freezed,
    Object? healthPlan = freezed,
    Object? authorizationCode = freezed,
    Object? authorizationDateCreated = freezed,
    Object? authorizationDateLimit = freezed,
    Object? attendance = freezed,
    Object? description = freezed,
    Object? confirmedPresence = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      professional: freezed == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      procedure: freezed == procedure
          ? _value.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as ProcedureModel?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientModel?,
      healthPlan: freezed == healthPlan
          ? _value.healthPlan
          : healthPlan // ignore: cast_nullable_to_non_nullable
              as HealthPlanModel?,
      authorizationCode: freezed == authorizationCode
          ? _value.authorizationCode
          : authorizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      authorizationDateCreated: freezed == authorizationDateCreated
          ? _value.authorizationDateCreated
          : authorizationDateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorizationDateLimit: freezed == authorizationDateLimit
          ? _value.authorizationDateLimit
          : authorizationDateLimit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedPresence: freezed == confirmedPresence
          ? _value.confirmedPresence
          : confirmedPresence // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileModelCopyWith<$Res>? get professional {
    if (_value.professional == null) {
      return null;
    }

    return $UserProfileModelCopyWith<$Res>(_value.professional!, (value) {
      return _then(_value.copyWith(professional: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProcedureModelCopyWith<$Res>? get procedure {
    if (_value.procedure == null) {
      return null;
    }

    return $ProcedureModelCopyWith<$Res>(_value.procedure!, (value) {
      return _then(_value.copyWith(procedure: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PatientModelCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $PatientModelCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthPlanModelCopyWith<$Res>? get healthPlan {
    if (_value.healthPlan == null) {
      return null;
    }

    return $HealthPlanModelCopyWith<$Res>(_value.healthPlan!, (value) {
      return _then(_value.copyWith(healthPlan: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusModelCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusModelCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AttendanceModelCopyWith<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  factory _$$_AttendanceModelCopyWith(
          _$_AttendanceModel value, $Res Function(_$_AttendanceModel) then) =
      __$$_AttendanceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      UserProfileModel? professional,
      ProcedureModel? procedure,
      PatientModel? patient,
      HealthPlanModel? healthPlan,
      String? authorizationCode,
      DateTime? authorizationDateCreated,
      DateTime? authorizationDateLimit,
      DateTime? attendance,
      String? description,
      DateTime? confirmedPresence,
      StatusModel? status});

  @override
  $UserProfileModelCopyWith<$Res>? get professional;
  @override
  $ProcedureModelCopyWith<$Res>? get procedure;
  @override
  $PatientModelCopyWith<$Res>? get patient;
  @override
  $HealthPlanModelCopyWith<$Res>? get healthPlan;
  @override
  $StatusModelCopyWith<$Res>? get status;
}

/// @nodoc
class __$$_AttendanceModelCopyWithImpl<$Res>
    extends _$AttendanceModelCopyWithImpl<$Res, _$_AttendanceModel>
    implements _$$_AttendanceModelCopyWith<$Res> {
  __$$_AttendanceModelCopyWithImpl(
      _$_AttendanceModel _value, $Res Function(_$_AttendanceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? professional = freezed,
    Object? procedure = freezed,
    Object? patient = freezed,
    Object? healthPlan = freezed,
    Object? authorizationCode = freezed,
    Object? authorizationDateCreated = freezed,
    Object? authorizationDateLimit = freezed,
    Object? attendance = freezed,
    Object? description = freezed,
    Object? confirmedPresence = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_AttendanceModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      professional: freezed == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      procedure: freezed == procedure
          ? _value.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as ProcedureModel?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientModel?,
      healthPlan: freezed == healthPlan
          ? _value.healthPlan
          : healthPlan // ignore: cast_nullable_to_non_nullable
              as HealthPlanModel?,
      authorizationCode: freezed == authorizationCode
          ? _value.authorizationCode
          : authorizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      authorizationDateCreated: freezed == authorizationDateCreated
          ? _value.authorizationDateCreated
          : authorizationDateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorizationDateLimit: freezed == authorizationDateLimit
          ? _value.authorizationDateLimit
          : authorizationDateLimit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedPresence: freezed == confirmedPresence
          ? _value.confirmedPresence
          : confirmedPresence // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
    ));
  }
}

/// @nodoc

class _$_AttendanceModel implements _AttendanceModel {
  _$_AttendanceModel(
      {this.id,
      this.professional,
      this.procedure,
      this.patient,
      this.healthPlan,
      this.authorizationCode,
      this.authorizationDateCreated,
      this.authorizationDateLimit,
      this.attendance,
      this.description,
      this.confirmedPresence,
      this.status});

  @override
  final String? id;
  @override
  final UserProfileModel? professional;
  @override
  final ProcedureModel? procedure;
  @override
  final PatientModel? patient;
  @override
  final HealthPlanModel? healthPlan;
  @override
  final String? authorizationCode;
  @override
  final DateTime? authorizationDateCreated;
  @override
  final DateTime? authorizationDateLimit;
  @override
  final DateTime? attendance;
  @override
  final String? description;
  @override
  final DateTime? confirmedPresence;
  @override
  final StatusModel? status;

  @override
  String toString() {
    return 'AttendanceModel(id: $id, professional: $professional, procedure: $procedure, patient: $patient, healthPlan: $healthPlan, authorizationCode: $authorizationCode, authorizationDateCreated: $authorizationDateCreated, authorizationDateLimit: $authorizationDateLimit, attendance: $attendance, description: $description, confirmedPresence: $confirmedPresence, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.professional, professional) ||
                other.professional == professional) &&
            (identical(other.procedure, procedure) ||
                other.procedure == procedure) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.healthPlan, healthPlan) ||
                other.healthPlan == healthPlan) &&
            (identical(other.authorizationCode, authorizationCode) ||
                other.authorizationCode == authorizationCode) &&
            (identical(
                    other.authorizationDateCreated, authorizationDateCreated) ||
                other.authorizationDateCreated == authorizationDateCreated) &&
            (identical(other.authorizationDateLimit, authorizationDateLimit) ||
                other.authorizationDateLimit == authorizationDateLimit) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confirmedPresence, confirmedPresence) ||
                other.confirmedPresence == confirmedPresence) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      professional,
      procedure,
      patient,
      healthPlan,
      authorizationCode,
      authorizationDateCreated,
      authorizationDateLimit,
      attendance,
      description,
      confirmedPresence,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceModelCopyWith<_$_AttendanceModel> get copyWith =>
      __$$_AttendanceModelCopyWithImpl<_$_AttendanceModel>(this, _$identity);
}

abstract class _AttendanceModel implements AttendanceModel {
  factory _AttendanceModel(
      {final String? id,
      final UserProfileModel? professional,
      final ProcedureModel? procedure,
      final PatientModel? patient,
      final HealthPlanModel? healthPlan,
      final String? authorizationCode,
      final DateTime? authorizationDateCreated,
      final DateTime? authorizationDateLimit,
      final DateTime? attendance,
      final String? description,
      final DateTime? confirmedPresence,
      final StatusModel? status}) = _$_AttendanceModel;

  @override
  String? get id;
  @override
  UserProfileModel? get professional;
  @override
  ProcedureModel? get procedure;
  @override
  PatientModel? get patient;
  @override
  HealthPlanModel? get healthPlan;
  @override
  String? get authorizationCode;
  @override
  DateTime? get authorizationDateCreated;
  @override
  DateTime? get authorizationDateLimit;
  @override
  DateTime? get attendance;
  @override
  String? get description;
  @override
  DateTime? get confirmedPresence;
  @override
  StatusModel? get status;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceModelCopyWith<_$_AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
