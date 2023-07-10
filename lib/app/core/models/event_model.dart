import 'package:freezed_annotation/freezed_annotation.dart';

import 'attendance_model.dart';
import 'hour_model.dart';
import 'room_model.dart';
import 'status_model.dart';

part 'event_model.freezed.dart';

@freezed
abstract class EventModel with _$EventModel {
  factory EventModel({
    String? id,
    DateTime? day,
    HourModel? hour,
    DateTime? start,
    DateTime? end,
    RoomModel? room,
    List<AttendanceModel>? attendances,
    StatusModel? status,
    String? history,
  }) = _EventModel;
}
