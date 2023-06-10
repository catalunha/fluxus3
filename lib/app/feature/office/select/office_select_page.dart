import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'office_obj.dart';

class OfficeSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const OfficeSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(officeSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'uma região' : 'algumas regiões'}'),
      ),
      body: list.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return OfficeObj(
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
            Navigator.of(context).pop(ref.watch(officeSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
