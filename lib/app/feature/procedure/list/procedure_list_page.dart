import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../print/procedure_print_page.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'procedure_obj.dart';

class ProcedureListPage extends ConsumerWidget {
  const ProcedureListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(procedureListProvider);
    final listFiltered = ref.watch(procedureFilteredProvider);
    final procedureFilteredBy = ref.watch(procedureFilteredByProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${listFiltered.length} procedimentos'),
        actions: [
          list.when(
              data: (data) {
                if (data.isNotEmpty) {
                  return IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProcedurePrintPage(
                              list: listFiltered,
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.print),
                  );
                } else {
                  return Container();
                }
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container())
        ],
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
                  hintText: 'digite algo para busca por',
                ),
                onChanged: (value) {
                  ref.read(procedureSearchProvider.notifier).set(value);
                },
              ),
            ),
            Wrap(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: procedureFilteredBy ==
                            ProcedureFilterBy.code
                        ? const MaterialStatePropertyAll<Color>(Colors.black)
                        : null,
                  ),
                  onPressed: () {
                    ref
                        .read(procedureFilteredByProvider.notifier)
                        .set(ProcedureFilterBy.code);
                  },
                  child: const Text('Código'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: procedureFilteredBy ==
                            ProcedureFilterBy.name
                        ? const MaterialStatePropertyAll<Color>(Colors.black)
                        : null,
                  ),
                  onPressed: () {
                    ref
                        .read(procedureFilteredByProvider.notifier)
                        .set(ProcedureFilterBy.name);
                  },
                  child: const Text('Nome'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: procedureFilteredBy ==
                            ProcedureFilterBy.description
                        ? const MaterialStatePropertyAll<Color>(Colors.black)
                        : null,
                  ),
                  onPressed: () {
                    ref
                        .read(procedureFilteredByProvider.notifier)
                        .set(ProcedureFilterBy.description);
                  },
                  child: const Text('Descrição'),
                ),
              ],
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
