import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/anamnese_question_model.dart';

part 'states.freezed.dart';

enum AnamneseQuestionTypeStatus { boolean, intensity, text, numerical }

enum AnamneseQuestionFormStatus { initial, loading, success, error }

@freezed
abstract class AnamneseQuestionFormState with _$AnamneseQuestionFormState {
  factory AnamneseQuestionFormState({
    @Default(AnamneseQuestionFormStatus.initial)
    AnamneseQuestionFormStatus status,
    @Default('') String error,
    AnamneseQuestionModel? model,
  }) = _AnamneseQuestionFormState;
}
