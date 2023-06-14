import 'dart:developer';

import 'package:fluxus3/app/core/authentication/riverpod/auth_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/attendance_model.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/models/hour_model.dart';
import '../../../../core/models/room_model.dart';
import '../../../../core/models/status_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<EventModel?> eventRead(EventReadRef ref, {required String? id}) async {
  if (id != null) {
    final event = await ref.read(eventRepositoryProvider).readById(id);
    if (event != null) {
      ref.read(eventFormProvider.notifier).setModel(event);
      ref.watch(dayProvider.notifier).set(event.day);
      ref.watch(hourSelectedProvider.notifier).set(event.hour);
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
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class Day extends _$Day {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class HourSelected extends _$HourSelected {
  @override
  HourModel? build() {
    return null;
  }

  void set(HourModel? value) {
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
    int index = state.indexWhere((value) => value.id == model.id);
    if (index < 0) {
      state = [...state, model];
    }
  }

  void delete(AttendanceModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<AttendanceModel> temp = [...state];
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
      final auth = ref.read(authChNotProvider);
      final day = ref.read(dayProvider);
      final hour = ref.read(hourSelectedProvider);
      final room = ref.read(roomSelectedProvider);
      final status = ref.read(statusSelectedProvider);

      history = '''
+++
Agora: ${DateTime.now()}
Usuário: ${auth.user?.userName}
Dia: $day
Horário: ${hour?.id}-${hour?.name}-${hour?.start} as ${hour?.end}
Sala: ${room?.id}-${room?.name}
Status: ${status?.id}-${status?.name}
Atendimentos: ${ref.read(attendancesSelectedProvider).map((e) => e.id).toList()}
Descrição: $history
${state.model?.history}
          ''';

      EventModel? eventTemp;
      if (state.model != null) {
        eventTemp = state.model!.copyWith(
          day: day,
          hour: hour,
          room: room,
          status: status,
          history: history,
        );
      } else {
        eventTemp = EventModel(
          day: day,
          hour: hour,
          room: room,
          status: status,
          history: history,
        );
      }
      final eventId = await ref.read(eventRepositoryProvider).update(eventTemp);
      await _updateRelations(
        modelId: eventId,
        originalList: ref.read(attendancesOriginalProvider),
        selectedList: ref.read(attendancesSelectedProvider),
        relationColumn: 'attendances',
        relationTable: 'Attendance',
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

  Future<List<dynamic>> _updateRelations({
    required String modelId,
    required List<dynamic> originalList,
    required List<dynamic> selectedList,
    required String relationColumn,
    required String relationTable,
  }) async {
    List<dynamic> listResult = [...selectedList];
    List<dynamic> listFinal = [...originalList];
    final repository = ref.read(eventRepositoryProvider);

    for (var original in originalList) {
      int index = selectedList.indexWhere((model) => model.id == original.id);
      if (index < 0) {
        await repository.updateRelation(
          objectId: modelId,
          relationColumn: relationColumn,
          relationTable: relationTable,
          ids: [original.id!],
          add: false,
        );
        listFinal.removeWhere((element) => element.id == original.id);
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
      listFinal.add(result);
    }
    return listFinal;
  }
}
