import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/attendance_model.dart';

part 'states.freezed.dart';

enum AttendanceFormStatus { initial, loading, success, error }

@freezed
abstract class AttendanceFormState with _$AttendanceFormState {
  factory AttendanceFormState({
    @Default(AttendanceFormStatus.initial) AttendanceFormStatus status,
    @Default('') String error,
    AttendanceModel? model,
  }) = _AttendanceFormState;
}
