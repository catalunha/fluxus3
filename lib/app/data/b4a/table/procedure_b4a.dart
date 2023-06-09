import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/procedure_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/procedure_entity.dart';
import '../utils/parse_error_translate.dart';

class ProcedureB4a {
  Future<List<ProcedureModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${ProcedureEntity.className}.cols')) {
      query.keysToReturn(cols['${ProcedureEntity.className}.cols']!);
    }
    if (cols.containsKey('${ProcedureEntity.className}.pointers')) {
      query.includeObject(cols['${ProcedureEntity.className}.pointers']!);
    } else {
      query.includeObject(['expertise']);
    }

    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<ProcedureModel> listTemp = <ProcedureModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(ProcedureEntity().toModel(element));
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
        where: 'ProcedureRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<ProcedureModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
    query.whereEqualTo(ProcedureEntity.id, id);

    if (cols.containsKey('${ProcedureEntity.className}.cols')) {
      query.keysToReturn(cols['${ProcedureEntity.className}.cols']!);
    }
    if (cols.containsKey('${ProcedureEntity.className}.pointers')) {
      query.includeObject(cols['${ProcedureEntity.className}.pointers']!);
    } else {
      query.includeObject(['expertise']);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return ProcedureEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> update(ProcedureModel model) async {
    final parseObject = await ProcedureEntity().toParse(model);
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
        where: 'ProcedureRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(ProcedureEntity.className);
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
        where: 'ProcedureRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
