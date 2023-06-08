import 'expertise_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'procedure_model.freezed.dart';

@freezed
abstract class ProcedureModel with _$ProcedureModel {
  factory ProcedureModel({
    String? id,
    ExpertiseModel? expertise,
    String? code,
    String? name,
    double? cost,
  }) = _ProcedureModel;
}
