import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'filter_mark.dart';
import 'patient_obj.dart';

class PatientListPage extends ConsumerWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(patientListProvider);
    final listFiltered = ref.watch(patientFilteredProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pacientes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.patientSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return Column(
          children: [
            Wrap(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'digite um texto para pesquisa',
                  ),
                  onChanged: (value) {
                    ref.read(patientSearchProvider.notifier).set(value);
                  },
                ),
                const FilterMark(
                    title: 'Nome', status: PatientFilterStatus.name),
                const FilterMark(
                    title: 'Celular', status: PatientFilterStatus.phone),
                const FilterMark(
                    title: 'Nome Curto', status: PatientFilterStatus.nickname),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: listFiltered.length,
                itemBuilder: (context, index) {
                  final level = listFiltered[index];
                  return PatientObj(
                    model: level,
                  );
                },
              ),
            ),
            // Flexible(
            //   child: ListView.builder(
            //     itemCount: data.length,
            //     itemBuilder: (context, index) {
            //       final level = data[index];
            //       return PatientObj(
            //         model: level,
            //       );
            //     },
            //   ),
            // ),
          ],
        );
      }, error: (error, stackTrace) {
        log('Erro em Lista de pacientes');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de pacientes'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
