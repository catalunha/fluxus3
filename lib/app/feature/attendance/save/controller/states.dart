import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/room_model.dart';

part 'states.freezed.dart';

enum RoomFormStatus { initial, loading, success, error }

@freezed
abstract class RoomFormState with _$RoomFormState {
  factory RoomFormState({
    @Default(RoomFormStatus.initial) RoomFormStatus status,
    @Default('') String error,
    RoomModel? model,
  }) = _RoomFormState;
}
