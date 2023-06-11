import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'healthplantype_obj.dart';

class HealthPlanTypeSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const HealthPlanTypeSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(healthPlanTypeSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'um tipo de plano de saúde' : 'alguns tipos de plano de saúde'}'),
      ),
      body: list.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return HealthPlanTypeObj(
                model: level,
                isSingleValue: isSingleValue,
              );
            },
          );
        },
        error: (error, stackTrace) {
          log('Erro em Lista de healthPlanType');
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em Lista de healthPlanType'),
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
            Navigator.of(context)
                .pop(ref.watch(healthPlanTypeSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
