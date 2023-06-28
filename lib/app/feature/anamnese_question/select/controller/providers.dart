import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_question_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_question_entity.dart';

part 'providers.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
FutureOr<List<AnamneseQuestionModel>> anamneseQuestionSelect(
    AnamneseQuestionSelectRef ref) async {
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseQuestionEntity.className));
  query.orderByAscending('name');
  final list = await ref.read(anamneseQuestionRepositoryProvider).list(query);
  return list;
}

@riverpod
class AnamneseQuestionSelected extends _$AnamneseQuestionSelected {
  @override
  List<AnamneseQuestionModel> build() {
    return [];
  }

  void toggle(AnamneseQuestionModel model) {
    final int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      final List<AnamneseQuestionModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
