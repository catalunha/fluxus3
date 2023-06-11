import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/expertise_model.dart';

part 'states.freezed.dart';

enum ExpertiseFormStatus { initial, loading, success, error }

@freezed
abstract class ExpertiseFormState with _$ExpertiseFormState {
  factory ExpertiseFormState({
    @Default(ExpertiseFormStatus.initial) ExpertiseFormStatus status,
    @Default('') String error,
    ExpertiseModel? model,
  }) = _ExpertiseFormState;
}
