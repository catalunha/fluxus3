import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_group_obj.dart';
import 'controller/providers.dart';

class AnamneseGroupSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const AnamneseGroupSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamneseGroupSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Selecione ${isSingleValue ? 'um grupo' : 'alguns grupos'}'),
      ),
      body: list.when(
        data: (data) {
          return Wrap(
            children: [
              for (var hour in data) ...[AnamneseGroupObj(model: hour)]
            ],
          );
          /*
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return AnamneseGroupObj(
                model: level,
                isSingleValue: isSingleValue,
              );
            },
          );
          */
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
            Navigator.of(context).pop(ref.watch(anamneseGroupSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
