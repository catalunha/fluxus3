import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/patient_model.dart';
import '../../utils/pagination.dart';
import '../b4a_exception.dart';
import '../entity/patient_entity.dart';
import '../utils/parse_error_translate.dart';

class PatientB4a {
  Future<List<PatientModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    query.setLimit(500);
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${PatientEntity.className}.cols')) {
      query.keysToReturn(cols['${PatientEntity.className}.cols']!);
    }
    if (cols.containsKey('${PatientEntity.className}.pointers')) {
      query.includeObject(cols['${PatientEntity.className}.pointers']!);
    }
    // else {
    //   query.includeObject(['region']);
    // }
    ParseResponse? response;
    try {
      response = await query.query();
      final List<PatientModel> listTemp = <PatientModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await PatientEntity().toModel(element, cols: cols));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      final errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'PatientRepositoryB4a.list',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }

  Future<PatientModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
    query.whereEqualTo(PatientEntity.id, id);
    if (cols.containsKey('${PatientEntity.className}.cols')) {
      query.keysToReturn(cols['${PatientEntity.className}.cols']!);
    }
    if (cols.containsKey('${PatientEntity.className}.pointers')) {
      query.includeObject(cols['${PatientEntity.className}.pointers']!);
    }
    // else {
    //   query.includeObject(['region']);
    // }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return PatientEntity().toModel(response.results!.first, cols: cols);
      }
      throw B4aException(
        'Perfil do usuário não encontrado.',
        where: 'PatientRepositoryB4a.readById()',
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<String> update(PatientModel userProfileModel) async {
    final userProfileParse = await PatientEntity().toParse(userProfileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        final ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      final errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'PatientRepositoryB4a.update',
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
    final parseObject = PatientEntity().toParseRelation(
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
