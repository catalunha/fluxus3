import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/shared_model.dart';

part 'states.freezed.dart';

enum SharedFormStatus { initial, loading, success, error }

@freezed
abstract class SharedFormState with _$SharedFormState {
  factory SharedFormState({
    @Default(SharedFormStatus.initial) SharedFormStatus status,
    @Default('') String error,
    SharedModel? model,
  }) = _SharedFormState;
}
