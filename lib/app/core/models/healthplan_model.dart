import 'package:freezed_annotation/freezed_annotation.dart';

import 'healthplantype_model.dart';

part 'healthplan_model.freezed.dart';

@freezed
abstract class HealthPlanModel with _$HealthPlanModel {
  factory HealthPlanModel({
    String? id,
    HealthPlanTypeModel? healthPlanType,
    String? code,
    DateTime? due,
    String? description,
  }) = _HealthPlanModel;
}
