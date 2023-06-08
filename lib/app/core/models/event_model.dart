import 'package:freezed_annotation/freezed_annotation.dart';

import 'attendance_model.dart';
import 'room_model.dart';
import 'status_model.dart';

part 'event_model.freezed.dart';

@freezed
abstract class EventModel with _$EventModel {
  factory EventModel({
    String? id,
    List<AttendanceModel>? attendances,
    String? attendanceBrief,
    RoomModel? room,
    StatusModel? status,
    DateTime? start,
    DateTime? end,
    String? history,
  }) = _EventModel;
}
