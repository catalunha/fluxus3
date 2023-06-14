import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/hour_model.dart';

part 'states.freezed.dart';

enum HourFormStatus { initial, loading, success, error }

@freezed
abstract class HourFormState with _$HourFormState {
  factory HourFormState({
    @Default(HourFormStatus.initial) HourFormStatus status,
    @Default('') String error,
    HourModel? model,
  }) = _HourFormState;
}
