import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/event_model.dart';

part 'states.freezed.dart';

enum EventFormStatus { initial, loading, success, error, overbook }

@freezed
abstract class EventFormState with _$EventFormState {
  factory EventFormState({
    @Default(EventFormStatus.initial) EventFormStatus status,
    @Default('') String error,
    EventModel? model,
  }) = _EventFormState;
}
