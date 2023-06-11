import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/expertise_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/expertise_entity.dart';
import '../utils/parse_error_translate.dart';

class ExpertiseB4a {
  Future<List<ExpertiseModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${ExpertiseEntity.className}.cols')) {
      query.keysToReturn(cols['${ExpertiseEntity.className}.cols']!);
    }
    if (cols.containsKey('${ExpertiseEntity.className}.pointers')) {
      query.includeObject(cols['${ExpertiseEntity.className}.pointers']!);
    }

    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<ExpertiseModel> listTemp = <ExpertiseModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(ExpertiseEntity().toModel(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'ExpertiseRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<ExpertiseModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
    query.whereEqualTo(ExpertiseEntity.id, id);

    if (cols.containsKey('${ExpertiseEntity.className}.cols')) {
      query.keysToReturn(cols['${ExpertiseEntity.className}.cols']!);
    }
    if (cols.containsKey('${ExpertiseEntity.className}.pointers')) {
      query.includeObject(cols['${ExpertiseEntity.className}.pointers']!);
    }

    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return ExpertiseEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> update(ExpertiseModel model) async {
    final parseObject = await ExpertiseEntity().toParse(model);
    ParseResponse? parseResponse;
    try {
      parseResponse = await parseObject.save();

      if (parseResponse.success && parseResponse.results != null) {
        ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'ExpertiseRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(ExpertiseEntity.className);
    parseObject.objectId = modelId;
    ParseResponse? parseResponse;

    try {
      parseResponse = await parseObject.delete();
      if (parseResponse.success && parseResponse.results != null) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      var errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'ExpertiseRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
