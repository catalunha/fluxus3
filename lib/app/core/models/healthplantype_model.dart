import 'package:freezed_annotation/freezed_annotation.dart';

part 'healthplantype_model.freezed.dart';

@freezed
abstract class HealthPlanTypeModel with _$HealthPlanTypeModel {
  factory HealthPlanTypeModel({
    String? id,
    String? name,
  }) = _HealthPlanTypeModel;
}
