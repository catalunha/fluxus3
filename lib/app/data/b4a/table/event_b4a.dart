import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/event_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/event_entity.dart';
import '../utils/parse_error_translate.dart';

class EventB4a {
  Future<List<EventModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${EventEntity.className}.cols')) {
      query.keysToReturn(cols['${EventEntity.className}.cols']!);
    }
    if (cols.containsKey('${EventEntity.className}.pointers')) {
      query.includeObject(cols['${EventEntity.className}.pointers']!);
    } else {
      query.includeObject([
        EventEntity.hour,
        EventEntity.room,
        EventEntity.status,
      ]);
    }

    ParseResponse? response;
    try {
      response = await query.query();
      List<EventModel> listTemp = <EventModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await EventEntity().toModel(element, cols: cols));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'EventRepositoryB4a.list',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }

  Future<EventModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    query.whereEqualTo(EventEntity.id, id);
    if (cols.containsKey('${EventEntity.className}.cols')) {
      query.keysToReturn(cols['${EventEntity.className}.cols']!);
    }
    if (cols.containsKey('${EventEntity.className}.pointers')) {
      query.includeObject(cols['${EventEntity.className}.pointers']!);
    } else {
      query.includeObject([
        EventEntity.hour,
        EventEntity.room,
        EventEntity.status,
      ]);
    }
    query.first();
    try {
      var response = await query.query();

      if (response.success && response.results != null) {
        return EventEntity().toModel(response.results!.first, cols: cols);
      }
      throw B4aException(
        'Perfil do usuário não encontrado.',
        where: 'EventRepositoryB4a.readById()',
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<String> update(EventModel userProfileModel) async {
    final userProfileParse = await EventEntity().toParse(userProfileModel);
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
        where: 'EventRepositoryB4a.update',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }

  Future<void> updateRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) async {
    final parseObject = EventEntity().toParseRelation(
        objectId: objectId,
        relationColumn: relationColumn,
        relationTable: relationTable,
        ids: ids,
        add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
}
