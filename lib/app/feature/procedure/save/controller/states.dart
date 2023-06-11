import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/procedure_model.dart';

part 'states.freezed.dart';

enum ProcedureFormStatus { initial, loading, success, error }

@freezed
abstract class ProcedureFormState with _$ProcedureFormState {
  factory ProcedureFormState({
    @Default(ProcedureFormStatus.initial) ProcedureFormStatus status,
    @Default('') String error,
    ProcedureModel? model,
  }) = _ProcedureFormState;
}
