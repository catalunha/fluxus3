import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/healthplantype_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/healthplantype_entity.dart';
import '../utils/parse_error_translate.dart';

class HealthPlanTypeB4a {
  Future<List<HealthPlanTypeModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${HealthPlanTypeEntity.className}.cols')) {
      query.keysToReturn(cols['${HealthPlanTypeEntity.className}.cols']!);
    }
    if (cols.containsKey('${HealthPlanTypeEntity.className}.pointers')) {
      query.includeObject(cols['${HealthPlanTypeEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<HealthPlanTypeModel> listTemp = <HealthPlanTypeModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(HealthPlanTypeEntity().toModel(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'HealthPlanTypeRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<HealthPlanTypeModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(HealthPlanTypeEntity.className));
    query.whereEqualTo(HealthPlanTypeEntity.id, id);

    if (cols.containsKey('${HealthPlanTypeEntity.className}.cols')) {
      query.keysToReturn(cols['${HealthPlanTypeEntity.className}.cols']!);
    }
    if (cols.containsKey('${HealthPlanTypeEntity.className}.pointers')) {
      query.includeObject(cols['${HealthPlanTypeEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return HealthPlanTypeEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> update(HealthPlanTypeModel model) async {
    final parseObject = await HealthPlanTypeEntity().toParse(model);
    ParseResponse? parseResponse;
    try {
      parseResponse = await parseObject.save();

      if (parseResponse.success && parseResponse.results != null) {
        final ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'HealthPlanTypeRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(HealthPlanTypeEntity.className);
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
      final errorTranslated =
          ParseErrorTranslate.translate(parseResponse!.error!);
      throw B4aException(
        errorTranslated,
        where: 'HealthPlanTypeRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
