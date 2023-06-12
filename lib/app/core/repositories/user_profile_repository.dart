import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/b4a/table/user_profile_b4a.dart';
import '../models/user_profile_model.dart';
import '../../data/utils/pagination.dart';

class UserProfileRepository {
  final UserProfileB4a userProfileB4a = UserProfileB4a();

  UserProfileRepository();
  Future<List<UserProfileModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) =>
      userProfileB4a.list(query, pagination: pagination, cols: cols);

  Future<String> update(UserProfileModel userProfileModel) =>
      userProfileB4a.update(userProfileModel);

  Future<UserProfileModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) =>
      userProfileB4a.readById(id, cols: cols);

  // Future<UserProfileModel?> readByCPF(String? value) =>
  //     userProfileB4a.readByCPF(value);

  Future<void> updateRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) =>
      userProfileB4a.updateRelation(
          objectId: objectId,
          relationColumn: relationColumn,
          relationTable: relationTable,
          ids: ids,
          add: add);
}
