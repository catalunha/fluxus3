import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/office_model.dart';

part 'states.freezed.dart';

enum OfficeFormStatus { initial, loading, success, error }

@freezed
abstract class OfficeFormState with _$OfficeFormState {
  factory OfficeFormState({
    @Default(OfficeFormStatus.initial) OfficeFormStatus status,
    @Default('') String error,
    OfficeModel? model,
  }) = _OfficeFormState;
}
