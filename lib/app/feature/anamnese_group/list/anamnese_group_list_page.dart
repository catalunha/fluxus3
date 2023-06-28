import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/anamnese_group_model.dart';
import '../../../routes.dart';
import 'anamnese_group_obj.dart';
import 'controller/providers.dart';

class AnamneseGroupListPage extends ConsumerStatefulWidget {
  const AnamneseGroupListPage({super.key});

  @override
  ConsumerState<AnamneseGroupListPage> createState() =>
      _AnamneseGroupListPageState();
}

class _AnamneseGroupListPageState extends ConsumerState<AnamneseGroupListPage> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(anamneseGroupsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} Grupos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.anamneseGroupSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return ReorderableListView.builder(
          itemBuilder: (context, index) {
            final level = data[index];
            return AnamneseGroupObj(
              key: ValueKey(level.id),
              model: level,
            );
          },
          itemCount: data.length,
          onReorder: _onReorder,
        );
        /*
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return AnamneseGroupObj(
              model: level,
            );
          },
        );
        */
      }, error: (error, stackTrace) {
        log('Erro em Lista de cargos');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de cargos'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    List<AnamneseGroupModel> classOrderTemp =
        ref.read(anamneseGroupsProvider).requireValue;
    AnamneseGroupModel resourceId = classOrderTemp[oldIndex];
    classOrderTemp.removeAt(oldIndex);
    classOrderTemp.insert(newIndex, resourceId);
    ref.read(anamneseGroupsProvider.notifier).set(classOrderTemp);
  }
}
