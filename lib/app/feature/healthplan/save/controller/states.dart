import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/healthplan_model.dart';

part 'states.freezed.dart';

enum HealthPlanFormStatus { initial, loading, success, error }

@freezed
abstract class HealthPlanFormState with _$HealthPlanFormState {
  factory HealthPlanFormState({
    @Default(HealthPlanFormStatus.initial) HealthPlanFormStatus status,
    @Default('') String error,
    HealthPlanModel? model,
  }) = _HealthPlanFormState;
}
