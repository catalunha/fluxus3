import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/event_entity.dart';
import '../../../../data/b4a/entity/room_entity.dart';
import '../../../../data/b4a/entity/status_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<EventModel>> schedule(ScheduleRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final firstDay = ref.read(fistDayProvider);
  final lastDay = ref.read(lastDayProvider);
  query.whereGreaterThanOrEqualsTo(EventEntity.start, firstDay);
  query.whereLessThanOrEqualTo(EventEntity.end, lastDay);
  query.whereEqualTo(
      EventEntity.status,
      (ParseObject(StatusEntity.className)
            ..objectId = ref.watch(statusCurrentProvider).id)
          .toPointer());
  final list = await ref.read(eventRepositoryProvider).list(query, cols: {
    '${EventEntity.className}.cols': [
      EventEntity.start,
      EventEntity.end,
      EventEntity.room,
      EventEntity.status,
      EventEntity.attendances,
    ],
    '${EventEntity.className}.pointers': [
      EventEntity.room,
      EventEntity.status,
    ]
  });

  final QueryBuilder<ParseObject> queryRoom =
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
    final room = ref.watch(roomSelectedProvider);
    final eventsTemp = [
      ...events.where((e) => e.room?.id == room!.id).toList()
    ];
    state = eventsTemp;
  }
}

@riverpod
class StatusCurrent extends _$StatusCurrent {
  @override
  StatusModel build() {
    return StatusModel(id: 'ZDQA4njpdN');
  }

  void set(StatusModel? value) {
    state = value ?? StatusModel(id: 'ZDQA4njpdN');
  }
}

@riverpod
class StatusSelected extends _$StatusSelected {
  @override
  Future<StatusModel> build() async {
    final status =
        await ref.read(statusRepositoryProvider).readById('ZDQA4njpdN');
    ref.read(statusCurrentProvider.notifier).set(status);
    return status!;
  }

  Future<void> set(StatusModel? value) async {
    state = const AsyncLoading();
    // state = await AsyncValue.guard(() => value??StatusModel(id: 'ZDQA4njpdN'));
    try {
      if (value != null) {
        state = AsyncValue.data(value);
        ref.read(statusCurrentProvider.notifier).set(value);
        ref.invalidate(scheduleProvider);
      } else {
        throw Exception();
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('Erro em buscar status na agenda', stackTrace);
    }
  }
}
