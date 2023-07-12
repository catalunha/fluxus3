import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/log_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/log_entity.dart';
import '../utils/parse_error_translate.dart';

class LogB4a {
  Future<List<LogModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${LogEntity.className}.cols')) {
      query.keysToReturn(cols['${LogEntity.className}.cols']!);
    }
    if (cols.containsKey('${LogEntity.className}.pointers')) {
      query.includeObject(cols['${LogEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<LogModel> listTemp = <LogModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(LogEntity().toModel(element));
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
        where: 'LogRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<LogModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(LogEntity.className));
    query.whereEqualTo(LogEntity.id, id);

    if (cols.containsKey('${LogEntity.className}.cols')) {
      query.keysToReturn(cols['${LogEntity.className}.cols']!);
    }
    if (cols.containsKey('${LogEntity.className}.pointers')) {
      query.includeObject(cols['${LogEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return LogEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> save(LogModel model) async {
    final parseObject = await LogEntity().toParse(model);
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
        where: 'LogRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(LogEntity.className);
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
        where: 'LogRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
