import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/shared_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/shared_entity.dart';
import '../utils/parse_error_translate.dart';

class SharedB4a {
  Future<List<SharedModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${SharedEntity.className}.cols')) {
      query.keysToReturn(cols['${SharedEntity.className}.cols']!);
    }
    if (cols.containsKey('${SharedEntity.className}.pointers')) {
      query.includeObject(cols['${SharedEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<SharedModel> listTemp = <SharedModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(await SharedEntity().toModel(element, cols: cols));
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
        where: 'SharedRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<SharedModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    query.whereEqualTo(SharedEntity.id, id);

    if (cols.containsKey('${SharedEntity.className}.cols')) {
      query.keysToReturn(cols['${SharedEntity.className}.cols']!);
    }
    if (cols.containsKey('${SharedEntity.className}.pointers')) {
      query.includeObject(cols['${SharedEntity.className}.pointers']!);
    } else {
      query.includeObject([
        'professional',
        'professional.region',
        'procedure',
        'procedure.expertise',
        'patient',
        'patient.region',
        'healthPlan',
        'healthPlan.healthPlanType',
        'status',
      ]);
    }
    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return SharedEntity().toModel(response.results!.first, cols: cols);
      }
      throw B4aException(
        'Perfil do usuário não encontrado.',
        where: 'SharedRepositoryB4a.readById()',
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<String> update(SharedModel model) async {
    final parseObject = await SharedEntity().toParse(model);
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
        where: 'SharedRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(SharedEntity.className);
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
        where: 'SharedRepositoryB4a.delete',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
