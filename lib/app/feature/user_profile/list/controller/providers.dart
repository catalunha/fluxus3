import 'package:fluxus3/app/core/models/user_profile_model.dart';
import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/b4a/entity/user_profile_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<UserProfileModel>> userProfileList(UserProfileListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
  query.orderByAscending('name');
  return await ref.read(userProfileRepositoryProvider).list(query);
}
