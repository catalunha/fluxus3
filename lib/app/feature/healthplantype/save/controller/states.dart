import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/healthplantype_model.dart';

part 'states.freezed.dart';

enum HealthPlanTypeFormHealthPlanType { initial, loading, success, error }

@freezed
abstract class HealthPlanTypeFormState with _$HealthPlanTypeFormState {
  factory HealthPlanTypeFormState({
    @Default(HealthPlanTypeFormHealthPlanType.initial)
    HealthPlanTypeFormHealthPlanType healthPlanType,
    @Default('') String error,
    HealthPlanTypeModel? model,
  }) = _HealthPlanTypeFormState;
}
