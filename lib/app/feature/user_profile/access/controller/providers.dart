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
    '${UserProfileEntity.className}.cols': [
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
    ref.watch(isActiveProvider.notifier).set(userProfile.isActive);
    ref.watch(userProfileAccessFormProvider.notifier).setModel(userProfile);
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

@riverpod
class IsActive extends _$IsActive {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

// final isActive1Provider = StateProvider.autoDispose<bool>(
//   (ref) {
//     return false;
//   },
//   name: 'isActiveProvider',
// );

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
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<OfficeModel> temp = [...state];
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
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<ExpertiseModel> temp = [...state];
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
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<ProcedureModel> temp = [...state];
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
    final int index = state.indexWhere((value) => value == status);
    if (index >= 0) {
      final List<AccessStatus> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, status];
    }
  }
}

@riverpod
class UserProfileAccessForm extends _$UserProfileAccessForm {
  @override
  UserProfileAccessFormState build() {
    return UserProfileAccessFormState();
  }

  void setModel(UserProfileModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm() async {
    state = state.copyWith(status: UserProfileAccessFormStatus.loading);
    try {
      final repository = ref.read(userProfileRepositoryProvider);
      final UserProfileModel userProfileModel = state.model!.copyWith(
        isActive: ref.read(isActiveProvider),
        access: ref.read(accessStateProvider).map((e) => e.name).toList(),
      );
      await repository.update(userProfileModel);

      await _updateRelations(
        modelId: state.model!.id,
        originalList: ref.read(officesOriginalProvider),
        selectedList: ref.read(officesSelectedProvider),
        relationColumn: 'offices',
        relationTable: 'Office',
      );
      await _updateRelations(
        modelId: state.model!.id,
        originalList: ref.read(expertisesOriginalProvider),
        selectedList: ref.read(expertisesSelectedProvider),
        relationColumn: 'expertises',
        relationTable: 'Expertise',
      );
      await _updateRelations(
        modelId: state.model!.id,
        originalList: ref.read(proceduresOriginalProvider),
        selectedList: ref.read(proceduresSelectedProvider),
        relationColumn: 'procedures',
        relationTable: 'Procedure',
      );
      state = state.copyWith(status: UserProfileAccessFormStatus.success);
    } catch (e) {
      state = state.copyWith(
          status: UserProfileAccessFormStatus.error,
          error: 'Erro em editar usuario');
    }
  }

  Future<List<dynamic>> _updateRelations({
    required String modelId,
    required List<dynamic> originalList,
    required List<dynamic> selectedList,
    required String relationColumn,
    required String relationTable,
  }) async {
    final List<dynamic> listResult = [...selectedList];
    final List<dynamic> listFinal = [...originalList];
    final repository = ref.read(userProfileRepositoryProvider);

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
