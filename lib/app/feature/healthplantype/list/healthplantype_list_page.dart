import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'healthplantype_obj.dart';

class HealthPlanTypeListPage extends ConsumerWidget {
  const HealthPlanTypeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(healthPlanTypeListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Planos de Saúde'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.healthPlanTypeSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return HealthPlanTypeObj(
              model: level,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em Lista de healthPlanTypeList');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de healthPlanTypeList'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
