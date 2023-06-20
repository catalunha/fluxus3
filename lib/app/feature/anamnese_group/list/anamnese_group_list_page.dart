import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'anamnese_group_obj.dart';
import 'controller/providers.dart';

class AnamneseGroupListPage extends ConsumerWidget {
  const AnamneseGroupListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamneseGroupListProvider);
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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return AnamneseGroupObj(
              model: level,
            );
          },
        );
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
}
