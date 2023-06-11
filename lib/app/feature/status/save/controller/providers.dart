import 'dart:developer';

import 'package:fluxus3/app/feature/room/save/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/room_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../list/controller/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<RoomModel?> roomRead(RoomReadRef ref, {required String? id}) async {
  if (id != null) {
    final room = await ref.read(roomRepositoryProvider).readById(id);
    if (room != null) {
      ref.watch(roomFormProvider.notifier).setModel(room);
      ref.watch(roomIsActiveProvider.notifier).set(room.isActive ?? false);
      return room;
    }
  }
  return null;
  // else {
  //   throw Error.throwWithStackTrace(
  //       'Não achei cargo com este id', StackTrace.current);
  // }
}

@riverpod
class RoomIsActive extends _$RoomIsActive {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class RoomForm extends _$RoomForm {
  @override
  RoomFormState build() {
    return RoomFormState();
  }

  void setModel(RoomModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({required String name}) async {
    state = state.copyWith(status: RoomFormStatus.loading);
    try {
      RoomModel? roomTemp;
      if (state.model != null) {
        roomTemp = state.model!.copyWith(
          name: name,
          isActive: ref.read(roomIsActiveProvider),
        );
      } else {
        roomTemp = RoomModel(
          name: name,
          isActive: ref.read(roomIsActiveProvider),
        );
      }
      await ref.read(roomRepositoryProvider).update(roomTemp);
      ref.invalidate(roomListProvider);
      state = state.copyWith(status: RoomFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: RoomFormStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: RoomFormStatus.loading);
    try {
      await ref.read(roomRepositoryProvider).delete(state.model!.id!);
      ref.invalidate(roomListProvider);
      state = state.copyWith(status: RoomFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: RoomFormStatus.error, error: 'Erro em editar cargo');
    }
  }
}
