import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/region_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/region_entity.dart';
import '../utils/parse_error_translate.dart';

class RegionB4a {
  Future<List<RegionModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${RegionEntity.className}.cols')) {
      query.keysToReturn(cols['${RegionEntity.className}.cols']!);
    }
    if (cols.containsKey('${RegionEntity.className}.pointers')) {
      query.includeObject(cols['${RegionEntity.className}.pointers']!);
    }

    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      List<RegionModel> listTemp = <RegionModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(RegionEntity().toModel(element));
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
        where: 'RegionRepositoryB4a.list',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<String> update(RegionModel model) async {
    final parseObject = await RegionEntity().toParse(model);
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
        where: 'RegionRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(RegionEntity.className);
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
        where: 'RegionRepositoryB4a.update',
        originalError:
            '${parseResponse.error!.code} -${parseResponse.error!.message}',
      );
    }
  }
}
