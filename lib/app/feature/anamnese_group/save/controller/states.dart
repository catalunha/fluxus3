import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';

part 'states.freezed.dart';

enum AnamneseGroupFormStatus { initial, loading, success, error }

@freezed
abstract class AnamneseGroupFormState with _$AnamneseGroupFormState {
  factory AnamneseGroupFormState({
    @Default(AnamneseGroupFormStatus.initial) AnamneseGroupFormStatus status,
    @Default('') String error,
    AnamneseGroupModel? model,
  }) = _AnamneseGroupFormState;
}
