import 'healthplan_model.dart';
import 'patient_model.dart';
import 'procedure_model.dart';
import 'status_model.dart';
import 'user_profile_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';

@freezed
abstract class AttendanceModel with _$AttendanceModel {
  factory AttendanceModel({
    String? id,
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
    StatusModel? status,
  }) = _AttendanceModel;
}
