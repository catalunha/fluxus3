import 'package:fluxus3/app/core/models/anamnese_people_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum AnswerTypeBooleanStatus { none, yes, no }

enum AnamnesePeopleFormStatus { initial, loading, success, error }

@freezed
abstract class AnamnesePeopleFormState with _$AnamnesePeopleFormState {
  factory AnamnesePeopleFormState({
    @Default(AnamnesePeopleFormStatus.initial) AnamnesePeopleFormStatus status,
    @Default('') String error,
    AnamnesePeopleModel? model,
  }) = _AnamnesePeopleFormState;
}
