import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/expertise_model.dart';
import '../../../../core/models/office_model.dart';
import '../../../../core/models/procedure_model.dart';
import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<UserProfileModel> userProfileAccessRead(UserProfileAccessReadRef ref,
    {required String id}) async {
  final userProfile =
      await ref.read(userProfileRepositoryProvider).readById(id, cols: {
    "${UserProfileEntity.className}.cols": [
      UserProfileEntity.userName,
      UserProfileEntity.email,
      UserProfileEntity.isActive,
      UserProfileEntity.access,
      UserProfileEntity.photo,
      UserProfileEntity.nickname,
      UserProfileEntity.offices,
      UserProfileEntity.expertises,
      UserProfileEntity.procedures,
    ]
  });
  if (userProfile != null) {
    ref.watch(isActiveProvider.notifier).state = userProfile.isActive;
    ref.watch(userProfileAccessModelProvider.notifier).state = userProfile;
    for (var access in userProfile.access) {
      ref.watch(accessStateProvider.notifier).update(access.toAccessStatus);
    }
    ref.watch(officesOriginalProvider.notifier).set(userProfile.offices ?? []);
    if (userProfile.offices != null) {
      for (var item in userProfile.offices!) {
        ref.watch(officesSelectedProvider.notifier).update(item);
      }
    }
    ref
        .watch(expertisesOriginalProvider.notifier)
        .set(userProfile.expertises ?? []);

    if (userProfile.expertises != null) {
      for (var item in userProfile.expertises!) {
        ref.watch(expertisesSelectedProvider.notifier).update(item);
      }
    }
    ref
        .watch(proceduresOriginalProvider.notifier)
        .set(userProfile.procedures ?? []);

    if (userProfile.procedures != null) {
      for (var item in userProfile.procedures!) {
        ref.watch(proceduresSelectedProvider.notifier).update(item);
      }
    }
    return userProfile;
  } else {
    throw Error.throwWithStackTrace(
        'Não achei usuário com este id', StackTrace.current);
  }
}

final userProfileAccessModelProvider =
    StateProvider.autoDispose<UserProfileModel?>(
  (ref) {
    return null;
  },
  name: 'userProfileAccessModelProvider',
);

final isActiveProvider = StateProvider.autoDispose<bool>(
  (ref) {
    return false;
  },
  name: 'isActiveProvider',
);

@riverpod
class OfficesOriginal extends _$OfficesOriginal {
  @override
  List<OfficeModel> build() {
    return [];
  }

  void set(List<OfficeModel> list) {
    state = list;
  }
}

@riverpod
class OfficesSelected extends _$OfficesSelected {
  @override
  List<OfficeModel> build() {
    return [];
  }

  void update(OfficeModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<OfficeModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}

@riverpod
class ExpertisesOriginal extends _$ExpertisesOriginal {
  @override
  List<ExpertiseModel> build() {
    return [];
  }

  void set(List<ExpertiseModel> list) {
    state = list;
  }
}

@riverpod
class ExpertisesSelected extends _$ExpertisesSelected {
  @override
  List<ExpertiseModel> build() {
    return [];
  }

  void update(ExpertiseModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<ExpertiseModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}

@riverpod
class ProceduresOriginal extends _$ProceduresOriginal {
  @override
  List<ProcedureModel> build() {
    return [];
  }

  void set(List<ProcedureModel> list) {
    state = list;
  }
}

@riverpod
class ProceduresSelected extends _$ProceduresSelected {
  @override
  List<ProcedureModel> build() {
    return [];
  }

  void update(ProcedureModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<ProcedureModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}

@riverpod
class AccessState extends _$AccessState {
  @override
  List<AccessStatus> build() {
    return [];
  }

  void update(AccessStatus status) {
    int index = state.indexWhere((value) => value == status);
    if (index >= 0) {
      List<AccessStatus> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, status];
    }
  }

  // List<String> toString() {
  //   state.map((e) => e.name).toList();
  // }
}

final userProfileAccessSaveStatusProvider =
    StateProvider.autoDispose<UserProfileAccessSaveStatus>(
  (ref) => UserProfileAccessSaveStatus.initial,
  name: 'userProfileAccessSaveStatusProvider',
);

final userProfileAccessSaveErrorProvider = StateProvider.autoDispose<String>(
  (ref) => '',
  name: 'userProfileAccessSaveErrorProvider',
);

@riverpod
class UserProfileAccessSave extends _$UserProfileAccessSave {
  @override
  build() {
    return;
  }

  Future<void> submitForm() async {
    ref.read(userProfileAccessSaveStatusProvider.notifier).state =
        UserProfileAccessSaveStatus.loading;
    try {
      final repository = ref.read(userProfileRepositoryProvider);
      final model = ref.read(userProfileAccessModelProvider);
      UserProfileModel userProfileModel = model!.copyWith(
        isActive: ref.read(isActiveProvider),
        access: ref.read(accessStateProvider).map((e) => e.name).toList(),
        // offices: ref.read(officeSelectedProvider),
        // expertises: ref.read(expertiseSelectedProvider),
        // procedures: ref.read(procedureSelectedProvider),
      );
      await repository.update(userProfileModel);

      await _updateRelations(
        modelId: model.id,
        originalList: ref.read(officesOriginalProvider),
        selectedList: ref.read(officesSelectedProvider),
        relationColumn: 'offices',
        relationTable: 'Office',
      );
      await _updateRelations(
        modelId: model.id,
        originalList: ref.read(expertisesOriginalProvider),
        selectedList: ref.read(expertisesSelectedProvider),
        relationColumn: 'expertises',
        relationTable: 'Expertise',
      );
      await _updateRelations(
        modelId: model.id,
        originalList: ref.read(proceduresOriginalProvider),
        selectedList: ref.read(proceduresSelectedProvider),
        relationColumn: 'procedures',
        relationTable: 'Procedure',
      );
      ref.read(userProfileAccessSaveStatusProvider.notifier).state =
          UserProfileAccessSaveStatus.success;
    } catch (e) {
      ref.read(userProfileAccessSaveErrorProvider.notifier).state =
          'Erro em editar usuario';
      ref.read(userProfileAccessSaveStatusProvider.notifier).state =
          UserProfileAccessSaveStatus.error;
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
    final repository = ref.read(userProfileRepositoryProvider);

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
