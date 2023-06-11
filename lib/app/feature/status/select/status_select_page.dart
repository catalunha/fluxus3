import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'status_obj.dart';

class StatusSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const StatusSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(statusSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Selecione ${isSingleValue ? 'um status' : 'alguns status'}'),
      ),
      body: list.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return StatusObj(
                model: level,
                isSingleValue: isSingleValue,
              );
            },
          );
        },
        error: (error, stackTrace) {
          log('Erro em Lista de status');
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em Lista de status'),
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
            Navigator.of(context).pop(ref.watch(statusSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
