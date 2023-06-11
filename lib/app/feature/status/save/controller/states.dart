import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/status_model.dart';

part 'states.freezed.dart';

enum StatusFormStatus { initial, loading, success, error }

@freezed
abstract class StatusFormState with _$StatusFormState {
  factory StatusFormState({
    @Default(StatusFormStatus.initial) StatusFormStatus status,
    @Default('') String error,
    StatusModel? model,
  }) = _StatusFormState;
}
