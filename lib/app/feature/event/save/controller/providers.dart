import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/authentication/riverpod/auth_prov.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/models/log_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/attendance_entity.dart';
import '../../../../data/b4a/entity/event_entity.dart';
import '../../../../data/b4a/entity/room_entity.dart';
import '../../../utils/app_extensions.dart';
import '../../search/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<EventModel?> eventRead(EventReadRef ref, {required String? id}) async {
  if (id != null) {
    final event = await ref.read(eventRepositoryProvider).readById(id, cols: {
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
    if (event != null) {
      ref.watch(eventFormProvider.notifier).setModel(event);
      ref.watch(dateSelectedProvider.notifier).set(event.start);
      ref
          .watch(startSelectedProvider.notifier)
          .set(TimeOfDay(hour: event.start!.hour, minute: event.start!.minute));
      ref
          .watch(endSelectedProvider.notifier)
          .set(TimeOfDay(hour: event.end!.hour, minute: event.end!.minute));
      ref.watch(roomSelectedProvider.notifier).set(event.room);
      ref.watch(statusSelectedProvider.notifier).set(event.status);
      ref
          .watch(attendancesOriginalProvider.notifier)
          .set(event.attendances ?? []);
      if (event.attendances != null) {
        for (var item in event.attendances!) {
          ref.watch(attendancesSelectedProvider.notifier).add(item);
        }
      }
      return event;
    }
  } else {
    final repo = ref.read(statusRepositoryProvider);
    final status = await repo.readById('ZDQA4njpdN');
    ref.watch(statusSelectedProvider.notifier).set(status);
    // ref
    //     .read(statusSelectedProvider.notifier)
    //     .set(StatusModel(id: 'ZDQA4njpdN'));
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class DateSelected extends _$DateSelected {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class StartSelected extends _$StartSelected {
  @override
  TimeOfDay? build() {
    return null;
  }

  void set(TimeOfDay? value) {
    state = value;
  }
}

@riverpod
class EndSelected extends _$EndSelected {
  @override
  TimeOfDay? build() {
    return null;
  }

  void set(TimeOfDay? value) {
    state = value;
  }
}

@riverpod
class RoomSelected extends _$RoomSelected {
  @override
  RoomModel? build() {
    return null;
  }

  void set(RoomModel? value) {
    state = value;
  }
}

@riverpod
class StatusSelected extends _$StatusSelected {
  @override
  StatusModel? build() {
    return null;
  }

  void set(StatusModel? value) {
    state = value;
  }
}

@riverpod
class AttendancesOriginal extends _$AttendancesOriginal {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void set(List<AttendanceModel> list) {
    state = list;
  }
}

@riverpod
class AttendancesSelected extends _$AttendancesSelected {
  @override
  List<AttendanceModel> build() {
    return [];
  }

  void add(AttendanceModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index < 0) {
      state = [...state, model];
    }
  }

  void delete(AttendanceModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<AttendanceModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    }
  }
}

@riverpod
class EventForm extends _$EventForm {
  @override
  EventFormState build() {
    return EventFormState();
  }

  void setModel(EventModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String history}) async {
    state = state.copyWith(status: EventFormStatus.loading);
    try {
      final date = ref.read(dateSelectedProvider);
      final start = ref.read(startSelectedProvider);
      final end = ref.read(endSelectedProvider);
      final status = ref.read(statusSelectedProvider);
      final room = ref.read(roomSelectedProvider);
      final attendancesUpdated = ref.read(attendancesSelectedProvider);
      if (date == null ||
          start == null ||
          end == null ||
          start.compareTo(end) == 0 ||
          start.compareTo(end) > 0 ||
          status == null ||
          room == null ||
          attendancesUpdated.isEmpty) {
        state = state.copyWith(
          status: EventFormStatus.error,
          error:
              'Faltam informações obrigatórias com * ou horários são incoerentes.',
        );
        return;
      }

      final DateTime dateStart =
          DateTime(date.year, date.month, date.day, start.hour, start.minute);
      final DateTime dateEnd =
          DateTime(date.year, date.month, date.day, end.hour, end.minute);

      bool checked = false;
      log('Start checkOverBook');
      if (state.model != null) {
        if (dateStart.compareTo(state.model!.start!) != 0 ||
            dateEnd.compareTo(state.model!.end!) != 0 ||
            room != state.model!.room) {
          log('eventId: ${state.model!.id}  checkOverBook');
          checked =
              await checkOverBookOr(state.model!.id, dateStart, dateEnd, room);
        }
      } else {
        log('new event checkOverBook');
        checked = await checkOverBookOr(null, dateStart, dateEnd, room);
      }

      if (checked) {
        state = state.copyWith(
            status: EventFormStatus.overbook,
            error: 'Já existe evento para este dia, horário e sala.');
        return;
      }

      EventModel? eventTemp;
      if (state.model != null) {
        eventTemp = state.model!.copyWith(
          start: dateStart,
          end: dateEnd,
          room: room,
          status: status,
        );
      } else {
        eventTemp = EventModel(
          start: dateStart,
          end: dateEnd,
          room: room,
          status: status,
        );
      }
      _savingLog('${eventTemp.toString()} | $history');

      final eventId = await ref.read(eventRepositoryProvider).update(eventTemp);
      _updateAttendances(
        eventId: eventId,
        list: ref.read(attendancesOriginalProvider),
        dateStart: dateStart,
        room: room,
        status: status,
      );

      await _updateRelations(
        modelId: eventId,
        originalList: ref.read(attendancesOriginalProvider),
        selectedList: ref.read(attendancesSelectedProvider),
        relationColumn: 'attendances',
        relationTable: 'Attendance',
        dateStart: dateStart,
      );
      ref.invalidate(eventListProvider);
      state = state.copyWith(status: EventFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: EventFormStatus.error, error: 'Erro em editar evento');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: EventFormStatus.loading);
    try {
      // await ref.read(eventRepositoryProvider).delete(state.model!.id!);
      // ref.invalidate(eventListProvider);
      state = state.copyWith(status: EventFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: EventFormStatus.error, error: 'Erro em editar evento');
    }
  }

  Future<void> _updateRelations({
    required String modelId,
    required List<AttendanceModel> originalList,
    required List<AttendanceModel> selectedList,
    required String relationColumn,
    required String relationTable,
    required DateTime dateStart,
  }) async {
    final List<AttendanceModel> listResult = [...selectedList];
    // final List<AttendanceModel> listFinal = [...originalList];
    final repository = ref.read(eventRepositoryProvider);

    for (var original in originalList) {
      final int index =
          selectedList.indexWhere((model) => model.id == original.id);
      if (index < 0) {
        await repository.updateRelation(
          objectId: modelId,
          relationColumn: relationColumn,
          relationTable: relationTable,
          ids: [original.id!],
          add: false,
        );
        //+++ atualizando atendimento de acordo com acoes do evento

        _savingLog(
            'Removendo Attendance ${original.id!} em event. Set AttendanceEntity.attendance=null, AttendanceEntity.status=iaAbxHHkjm');

        await ref
            .read(attendanceRepositoryProvider)
            .unset(original.id!, AttendanceEntity.attendance);
        await ref.read(attendanceRepositoryProvider).update(
              AttendanceModel(
                id: original.id,
                status: StatusModel(id: 'iaAbxHHkjm'),
              ),
            );
        //---
      } else {
        listResult.removeWhere((element) => element.id == original.id);
      }
    }
    for (var result in listResult) {
      await repository.updateRelation(
        objectId: modelId,
        relationColumn: relationColumn,
        relationTable: relationTable,
        ids: [result.id!],
        add: true,
      );
      //+++ atualizando atendimento de acordo com acoes do evento

      _savingLog(
          'Inserido Attendance ${result.id!} em event. Set AttendanceEntity.attendance=$dateStart, AttendanceEntity.status=9WGnM73WBI');

      await ref.read(attendanceRepositoryProvider).update(
            AttendanceModel(
              id: result.id,
              attendance: dateStart,
              status: StatusModel(id: '9WGnM73WBI'),
            ),
          );
      //---

      // listFinal.add(result);
    }
    // return listFinal;
  }

  Future<void> _updateAttendances({
    required String eventId,
    required List<AttendanceModel> list,
    required DateTime dateStart,
    required RoomModel room,
    required StatusModel status,
  }) async {
    for (var attendance in list) {
      _savingLog(
          'update Attendance ${attendance.id!} em event to room ${room.name}. Set AttendanceEntity.attendance=$dateStart, AttendanceEntity.status=$status');

      await ref.read(attendanceRepositoryProvider).update(
            AttendanceModel(
              id: attendance.id,
              attendance: dateStart,
              status: status,
            ),
          );
    }
  }

  Future<bool> checkOverBookOr(
    String? currentId,
    DateTime start,
    DateTime end,
    RoomModel room,
  ) async {
    //  BD------S----------E------
    // 1 N---S------E-------------
    // 2 N--------S------E--------
    // 3 N--------------S------E--
    // 4 N---S---------------E----
    log('+++ overbookOr');
    log('+++ overbook:$currentId');
    log('+++ overbook:$start');
    log('+++ overbook:$end');
    log('+++ overbook:$room');
    log('+++ overbook: Teste 1');
    //  BD------S----------E------
    // 1 N---S------E-------------
    final QueryBuilder<ParseObject> query1 =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    // if (currentId != null) {
    //   query1.whereNotEqualTo(EventEntity.id, currentId);
    // }
    query1.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query1.whereGreaterThanOrEqualsTo(EventEntity.start, start);
    query1.whereLessThanOrEqualTo(EventEntity.start, end);

    log('+++ overbook: Teste 2');
    //  BD------S----------E------
    // 2 N--------S------E--------
    final QueryBuilder<ParseObject> query2 =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    // if (currentId != null) {
    //   query2.whereNotEqualTo(EventEntity.id, currentId);
    // }
    query2.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query2.whereLessThanOrEqualTo(EventEntity.start, start);
    query2.whereGreaterThanOrEqualsTo(EventEntity.end, end);

    log('+++ overbook: Teste 3');
    //  BD------S----------E------
    // 3 N--------------S------E--
    final QueryBuilder<ParseObject> query3 =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    // if (currentId != null) {
    //   query3.whereNotEqualTo(EventEntity.id, currentId);
    // }
    query3.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query3.whereGreaterThanOrEqualsTo(EventEntity.end, start);
    query3.whereLessThanOrEqualTo(EventEntity.end, end);

    log('+++ overbook: Teste 4');
    //  BD------S----------E------
    // 4 N---S---------------E----
    final QueryBuilder<ParseObject> query4 =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    // if (currentId != null) {
    //   query4.whereNotEqualTo(EventEntity.id, currentId);
    // }
    query4.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query4.whereGreaterThanOrEqualsTo(EventEntity.start, start);
    query4.whereLessThanOrEqualTo(EventEntity.end, end);

    final QueryBuilder<ParseObject> queryFinal = QueryBuilder.or(
        ParseObject(EventEntity.className), [query1, query2, query3, query4]);
    queryFinal.whereNotEqualTo(EventEntity.id, currentId);

    final result = await queryOverbook(queryFinal);
    if (result) {
      return true;
    }
    return false;
  }

  Future<bool> checkOverBook(
    String? currentId,
    DateTime start,
    DateTime end,
    RoomModel room,
  ) async {
    //  BD------S----------E------
    // 1 N---S------E-------------
    // 2 N--------S------E--------
    // 3 N--------------S------E--
    // 4 N---S---------------E----
    log('+++ overbook:$currentId');
    log('+++ overbook:$start');
    log('+++ overbook:$end');
    log('+++ overbook:$room');
    log('+++ overbook: Teste 1');
    //  BD------S----------E------
    // 1 N---S------E-------------
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    if (currentId != null) {
      query.whereNotEqualTo(EventEntity.id, currentId);
    }
    query.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query.whereGreaterThanOrEqualsTo(EventEntity.start, start);
    query.whereLessThanOrEqualTo(EventEntity.start, end);
    var result = await queryOverbook(query);
    if (result) {
      return true;
    }
    log('+++ overbook: Teste 2');
    //  BD------S----------E------
    // 2 N--------S------E--------
    query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    if (currentId != null) {
      query.whereNotEqualTo(EventEntity.id, currentId);
    }
    query.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query.whereLessThanOrEqualTo(EventEntity.start, start);
    query.whereGreaterThanOrEqualsTo(EventEntity.end, end);
    result = await queryOverbook(query);
    if (result) {
      return true;
    }
    log('+++ overbook: Teste 3');
    //  BD------S----------E------
    // 3 N--------------S------E--
    query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    if (currentId != null) {
      query.whereNotEqualTo(EventEntity.id, currentId);
    }
    query.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query.whereGreaterThanOrEqualsTo(EventEntity.end, start);
    query.whereLessThanOrEqualTo(EventEntity.end, end);
    result = await queryOverbook(query);
    if (result) {
      return true;
    }
    log('+++ overbook: Teste 4');
    //  BD------S----------E------
    // 4 N---S---------------E----
    query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    if (currentId != null) {
      query.whereNotEqualTo(EventEntity.id, currentId);
    }
    query.whereEqualTo(EventEntity.room,
        (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
    query.whereGreaterThanOrEqualsTo(EventEntity.start, start);
    query.whereLessThanOrEqualTo(EventEntity.end, end);
    if (result) {
      return true;
    }

    return false;
  }

  Future<bool> queryOverbook(QueryBuilder<ParseObject> query) async {
    final list = await ref.read(eventRepositoryProvider).list(query, cols: {
      '${EventEntity.className}.cols': [
        EventEntity.id,
        EventEntity.start,
        EventEntity.end,
        EventEntity.room,
        // EventEntity.status,
      ],
      // '${EventEntity.className}.pointers': [
      //   EventEntity.room,
      //   EventEntity.status,
      // ]
    });
    for (final element in list) {
      log('overbook: $element');
    }
    if (list.isEmpty) {
      log('overbook: false');
      return false;
    } else {
      log('overbook: true');
      return true;
    }
  }

  void _savingLog(String action) {
    //Salvando dados em log
    final logRepo = ref.read(logRepositoryProvider);
    final auth = ref.read(authChNotProvider);
    logRepo.save(LogModel(
      userProfile: auth.user!.userProfile!.id,
      table: 'event',
      tableId: state.model != null ? state.model!.id! : 'new',
      action: action,
    ));
  }
}
