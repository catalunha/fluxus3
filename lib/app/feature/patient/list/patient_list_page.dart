import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'patient_obj.dart';

class PatientListPage extends ConsumerWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(patientListProvider);
    final listFiltered = ref.watch(patientFilteredProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} pacientes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.patientSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        // return ListView.builder(
        //   itemCount: ref.watch(patientFilteredProvider).length,
        //   itemBuilder: (context, index) {
        //     final level = ref.watch(patientFilteredProvider)[index];
        //     return PatientObj(
        //       model: level,
        //     );
        //   },
        // );
        // return ListView.builder(
        //   itemCount: data.length,
        //   itemBuilder: (context, index) {
        //     final level = data[index];
        //     return PatientObj(
        //       model: level,
        //     );
        //   },
        // );
        return Column(
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'digite parte do nome para busca',
                ),
                onChanged: (value) {
                  ref.read(patientSearchProvider.notifier).set(value);
                },
              ),
            ),

            Flexible(
              child: ListView.builder(
                itemCount: listFiltered.length,
                itemBuilder: (context, index) {
                  final level = listFiltered[index];
                  return PatientObj(model: level);
                },
              ),
            ),

            // Flexible(
            //   child: ListView.builder(
            //     itemCount: ref.watch(patientFilteredProvider).length,
            //     itemBuilder: (context, index) {
            //       final level = ref.watch(patientFilteredProvider)[index];
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
