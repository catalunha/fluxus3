import 'package:fluxus3/app/core/repositories/providers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/office_model.dart';
import '../../../../data/b4a/entity/office_entity.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<OfficeModel>> officeSelect(OfficeSelectRef ref) async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(OfficeEntity.className));
  query.orderByDescending('name');
  final list = await ref.read(officeRepositoryProvider).list(query);
  return list;
}

@riverpod
class OfficeSelected extends _$OfficeSelected {
  @override
  List<OfficeModel> build() {
    return [];
  }

  void toggle(OfficeModel model) {
    int index = state.indexWhere((value) => value.id == model.id);
    if (index >= 0) {
      List<OfficeModel> temp = [...state];
      temp.removeAt(index);
      state = [...temp];
    } else {
      state = [...state, model];
    }
  }
}
