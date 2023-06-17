import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/attendance_model.dart';

part 'states.freezed.dart';

enum AttendancePresencFormStatus { initial, loading, success, error }

@freezed
abstract class AttendancePresencFormState with _$AttendancePresencFormState {
  factory AttendancePresencFormState({
    @Default(AttendancePresencFormStatus.initial)
    AttendancePresencFormStatus status,
    @Default('') String error,
    @Default([]) List<AttendanceModel> all,
    @Default([]) List<AttendanceModel> confirmed,
  }) = _AttendanceFormState;
}
