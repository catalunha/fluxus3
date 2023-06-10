import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/user_profile_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/user_profile_entity.dart';
import '../utils/parse_error_translate.dart';

class UserProfileB4a {
  Future<List<UserProfileModel>> list({
    required QueryBuilder<ParseObject> query,
    Pagination? pagination,
    Map<String,List<String>>? cols,
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    cols.containsKey(key)
    query.keysToReturn(cols);
    query.includeObject(pointers);

    ParseResponse? response;
    try {
      response = await query.query();
      List<UserProfileModel> listTemp = <UserProfileModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await UserProfileEntity().toModel(element, cols));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'UserProfileRepositoryB4a.list',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }

  Future<UserProfileModel?> readById(
    String id, [
    List<String> cols = const [],
    List<String> pointers = const [],
  ]) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo(UserProfileEntity.id, id);
    if (cols.isNotEmpty) query.keysToReturn(cols);
    if (pointers.isEmpty) {
      query.includeObject(['region']);
    } else {
      query.includeObject(pointers);
    }

    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().toModel(response.results!.first, cols);
      }
      throw B4aException(
        'Perfil do usuário não encontrado.',
        where: 'UserProfileRepositoryB4a.readById()',
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> update(UserProfileModel userProfileModel) async {
    final userProfileParse =
        await UserProfileEntity().toParse(userProfileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'UserProfileRepositoryB4a.update',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }

  Future<void> updateRelationOffices(
      {required String objectId,
      required List<String> ids,
      required bool add}) async {
    final parseObject = UserProfileEntity()
        .toParseRelationOffices(objectId: objectId, ids: ids, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  Future<void> updateRelationExpertises(
      {required String objectId,
      required List<String> ids,
      required bool add}) async {
    final parseObject = UserProfileEntity()
        .toParseRelationExpertises(objectId: objectId, ids: ids, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  Future<void> updateRelationProcedures(
      {required String objectId,
      required List<String> ids,
      required bool add}) async {
    final parseObject = UserProfileEntity()
        .toParseRelationProcedures(objectId: objectId, ids: ids, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
/*
  Future<UserProfileModel?> readByCPF(String? value) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo(UserProfileEntity.cpf, value);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().fromParse(response.results!.first);
      } else {
        // throw Exception();
        return null;
      }
    } on Exception {
      var errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'UserProfileRepositoryB4a.getByRegister',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }
  */
}
