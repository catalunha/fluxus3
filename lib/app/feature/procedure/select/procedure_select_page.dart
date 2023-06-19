import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'procedure_obj.dart';

class ProcedureSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const ProcedureSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(procedureSelectProvider);
    final listFiltered = ref.watch(procedureFilteredProvider);
    final listSelected = ref.watch(procedureSelectedProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'um procedimento' : 'alguns procedimentos'}'),
      ),
      body: list.when(
        data: (data) {
          return Column(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  for (var model in listSelected) ...[
                    ProcedureObj(
                      model: model,
                      isSingleValue: isSingleValue,
                    )
                  ]
                ]),
              ),
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
              Expanded(
                child: ListView.builder(
                  itemCount: listFiltered.length,
                  itemBuilder: (context, index) {
                    final model = listFiltered[index];
                    return ProcedureObj(
                      model: model,
                      isSingleValue: isSingleValue,
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro em Lista de usuarios');
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em Lista de usuarios'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: !isSingleValue,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(ref.watch(procedureSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
