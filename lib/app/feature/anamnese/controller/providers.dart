import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_people_model.dart';
import '../../../core/repositories/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class ChildBirthDate extends _$ChildBirthDate {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class ChildIsFemale extends _$ChildIsFemale {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class AnamnesePeopleForm extends _$AnamnesePeopleForm {
  @override
  AnamnesePeopleFormState build() {
    return AnamnesePeopleFormState();
  }

  Future<void> submitForm({
    required String adultName,
    required String adultPhone,
    required String childName,
  }) async {
    state = state.copyWith(status: AnamnesePeopleFormStatus.loading);
    try {
      final childIsFemale = ref.read(childIsFemaleProvider);
      final childBirthDate = ref.read(childBirthDateProvider);

      final anamnesePeopleTemp = AnamnesePeopleModel(
        adultName: adultName,
        adultPhone: adultPhone,
        childName: childName,
        childIsFemale: childIsFemale,
        childBirthDate: childBirthDate!,
      );

      await ref.read(anamnesePeopleRepositoryProvider).save(anamnesePeopleTemp);

      state = state.copyWith(status: AnamnesePeopleFormStatus.success);
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamnesePeopleFormStatus.error,
          error: 'Erro em editar cargo');
    }
  }
}
