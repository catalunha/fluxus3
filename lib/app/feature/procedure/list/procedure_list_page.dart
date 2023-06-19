import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'procedure_obj.dart';

class ProcedureListPage extends ConsumerWidget {
  const ProcedureListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(procedureListProvider);
    final listFiltered = ref.watch(procedureFilteredProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} procedimentos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.procedureSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return Column(
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'digite parte da descrição para busca',
                ),
                onChanged: (value) {
                  ref.read(procedureSearchProvider.notifier).set(value);
                },
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: listFiltered.length,
                itemBuilder: (context, index) {
                  final model = listFiltered[index];
                  return ProcedureObj(
                    model: model,
                  );
                },
              ),
            ),
          ],
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
