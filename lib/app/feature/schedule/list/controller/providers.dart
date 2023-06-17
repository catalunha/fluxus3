import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/event_entity.dart';
import '../../../../data/b4a/entity/room_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<EventModel>> schedule(ScheduleRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final firstDay = ref.read(fistDayProvider);
  final lastDay = ref.read(lastDayProvider);
  query.whereGreaterThanOrEqualsTo(
      EventEntity.day, DateTime(firstDay.year, firstDay.month, firstDay.day));
  query.whereLessThanOrEqualTo(EventEntity.day,
      DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59));
  final list = await ref.read(eventRepositoryProvider).list(query, cols: {
    "${EventEntity.className}.cols": [
      EventEntity.day,
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
      EventEntity.attendances,
    ],
    "${EventEntity.className}.pointers": [
      EventEntity.hour,
      EventEntity.room,
      EventEntity.status,
    ]
  });

  QueryBuilder<ParseObject> queryRoom =
      QueryBuilder<ParseObject>(ParseObject(RoomEntity.className));
  queryRoom.orderByAscending('name');
  final rooms = await ref.read(roomRepositoryProvider).list(queryRoom);
  ref.read(roomsProvider.notifier).set(rooms);
  ref.read(roomSelectedProvider.notifier).set(rooms[0]);

  ref.read(eventsProvider.notifier).set(list);
  ref.read(eventsFilteredProvider.notifier).set(list);
  return list;
}

@riverpod
class FistDay extends _$FistDay {
  @override
  DateTime build() {
    var firstDay = DateTime.now();
    firstDay = DateTime(firstDay.year, firstDay.month, firstDay.day);
    return firstDay;
  }

  void set(DateTime? value) {
    if (value == null) {
      var firstDay = DateTime.now();
      firstDay = DateTime(firstDay.year, firstDay.month, firstDay.day);
      state = firstDay;
    } else {
      state = value;
    }
  }
}

@riverpod
class LastDay extends _$LastDay {
  @override
  DateTime build() {
    var lastDay = DateTime.now().add(const Duration(days: 7));
    lastDay = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59);
    return lastDay;
  }

  void set(DateTime? value) {
    if (value == null) {
      var lastDay = DateTime.now().add(const Duration(days: 7));
      lastDay = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59);
      state = lastDay;
    } else {
      state = DateTime(value.year, value.month, value.day, 23, 59);
    }
  }
}

@riverpod
class Rooms extends _$Rooms {
  @override
  List<RoomModel> build() {
    return [];
  }

  void set(List<RoomModel> value) {
    state = value;
  }
}

@riverpod
class RoomSelected extends _$RoomSelected {
  @override
  RoomModel? build() {
    return null;
  }

  void set(RoomModel value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class Events extends _$Events {
  @override
  List<EventModel> build() {
    return [];
  }

  void set(List<EventModel> value) {
    print('Events.set: $value');
    state = value;
  }
}

@riverpod
class EventsFiltered extends _$EventsFiltered {
  @override
  List<EventModel> build() {
    return [];
  }

  void set(List<EventModel> value) {
    final room = ref.read(roomSelectedProvider);
    final listTemp = [...value.where((e) => e.room?.id == room!.id).toList()];
    state = listTemp;
  }

  void filter() {
    final events = ref.watch(eventsProvider);
    print('filter.events: $events');
    final room = ref.watch(roomSelectedProvider);
    print('filter.room: $room');
    final eventsTemp = [
      ...events.where((e) => e.room?.id == room!.id).toList()
    ];
    print('filter.eventsTemp: $eventsTemp');
    state = eventsTemp;
  }
}
