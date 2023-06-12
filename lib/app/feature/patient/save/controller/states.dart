import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum PatientFormStatus { initial, loading, success, error }

@freezed
abstract class PatientFormState with _$PatientFormState {
  factory PatientFormState({
    @Default(PatientFormStatus.initial) PatientFormStatus status,
    @Default('') String error,
    PatientModel? model,
  }) = _PatientFormState;
}
