import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_question_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_question_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<AnamneseQuestionModel>> anamneseQuestionList(
    AnamneseQuestionListRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseQuestionEntity.className));
  query.orderByAscending('name');
  return await ref.read(anamneseQuestionRepositoryProvider).list(
    query,
    cols: {
      "${AnamneseQuestionEntity.className}.cols": [
        AnamneseQuestionEntity.text,
        AnamneseQuestionEntity.description,
        AnamneseQuestionEntity.type,
        AnamneseQuestionEntity.isActive,
        AnamneseQuestionEntity.isRequired,
        AnamneseQuestionEntity.anamneseGroup,
      ],
      "${AnamneseQuestionEntity.className}.pointers": [
        AnamneseQuestionEntity.anamneseGroup,
      ],
    },
  );
}
