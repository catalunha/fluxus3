import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'expertise_obj.dart';

class ExpertiseSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const ExpertiseSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(expertiseSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'uma especialidade' : 'algumas especialidades'}'),
      ),
      body: list.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return ExpertiseObj(
                model: level,
                isSingleValue: isSingleValue,
              );
            },
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
            Navigator.of(context).pop(ref.watch(expertiseSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
