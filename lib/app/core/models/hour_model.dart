import 'package:freezed_annotation/freezed_annotation.dart';

part 'hour_model.freezed.dart';

@freezed
abstract class HourModel with _$HourModel {
  factory HourModel({
    String? id,
    @Default('0') String name,
    DateTime? start,
    DateTime? end,
    bool? isActive,
  }) = _HourModel;
}
