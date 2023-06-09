import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/anamnese_group_model.dart';
import '../../../../core/models/anamnese_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/anamnese_group_entity.dart';

part 'providers.g.dart';

@riverpod
class AnamneseGroups extends _$AnamneseGroups {
  @override
  Future<List<AnamneseGroupModel>> build() async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
    query.orderByAscending('name');
    final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
      query,
      cols: {
        '${AnamneseGroupEntity.className}.cols': [
          AnamneseGroupEntity.name,
          AnamneseGroupEntity.description,
          AnamneseGroupEntity.isActive,
          AnamneseGroupEntity.orderOfQuestions,
        ],
      },
    );
    final anamnese =
        await ref.read(anamneseRepositoryProvider).readByName('orderOfGroups');
    var listGroupsReordened = <AnamneseGroupModel>[];
    if (anamnese != null && anamnese.orderOfGroups.isNotEmpty) {
      final Map<String, AnamneseGroupModel> mapping = {
        for (var group in listGroups) group.id!: group
      };
      for (var groupId in anamnese.orderOfGroups) {
        if (mapping.containsKey(groupId)) {
          listGroupsReordened.add(mapping[groupId]!);
        }
      }
    } else {
      if (listGroups.isNotEmpty) {
        await ref.read(anamneseRepositoryProvider).save(AnamneseModel(
            name: 'orderOfGroups',
            orderOfGroups: listGroups.map((e) => e.id!).toList()));
      }

      listGroupsReordened = [...listGroups];
    }
    return listGroupsReordened;
  }

  void set(List<AnamneseGroupModel> listReordered) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final itens = <String>[];
      for (var item in listReordered) {
        itens.add(item.id!);
      }
      var anamnese = await ref
          .read(anamneseRepositoryProvider)
          .readByName('orderOfGroups');
      anamnese ??= AnamneseModel(name: 'orderOfGroups');
      await ref
          .read(anamneseRepositoryProvider)
          .save(anamnese.copyWith(orderOfGroups: itens));
      return listReordered;
    });
  }
}





// @Riverpod(keepAlive: true)
// FutureOr<List<AnamneseGroupModel>> anamneseGroupList(
//     AnamneseGroupListRef ref) async {
//   QueryBuilder<ParseObject> query =
//       QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
//   query.orderByAscending('name');
//   return await ref.read(anamneseGroupRepositoryProvider).list(
//     query,
//     cols: {
//       "${AnamneseGroupEntity.className}.cols": [
//         AnamneseGroupEntity.name,
//         AnamneseGroupEntity.description,
//         AnamneseGroupEntity.isActive,
//         AnamneseGroupEntity.orderOfQuestions,
//       ],
//     },
//   );
// }
