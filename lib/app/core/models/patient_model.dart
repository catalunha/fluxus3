import 'healthplan_model.dart';
import 'region_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';

@freezed
abstract class PatientModel with _$PatientModel {
  factory PatientModel({
    String? id,
    String? email,
    String? phone,
    String? nickname,
    String? name,
    String? cpf,
    bool? isFemale,
    DateTime? birthday,
    String? address,
    RegionModel? region,
    List<PatientModel>? family,
    List<HealthPlanModel>? healthPlans,
  }) = _PatientModel;
}
