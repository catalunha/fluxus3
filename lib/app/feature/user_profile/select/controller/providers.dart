import 'package:fluxus3/app/core/models/user_profile_model.dart';
import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/b4a/entity/user_profile_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<UserProfileModel>> userProfileSelect(
    UserProfileSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(userProfileRepositoryProvider).list(query, cols: {
    "${UserProfileEntity.className}.cols": [
      UserProfileEntity.userName,
      UserProfileEntity.email,
      UserProfileEntity.isActive,
      UserProfileEntity.access,
      // UserProfileEntity.name,
      UserProfileEntity.nickname,
      // UserProfileEntity.procedures,
    ]
  });
  return list;
}

@riverpod
class UserProfileSelected extends _$UserProfileSelected {
  @override
  List<UserProfileModel> build() {
    return [];
  }

  void toggle(UserProfileModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<UserProfileModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
