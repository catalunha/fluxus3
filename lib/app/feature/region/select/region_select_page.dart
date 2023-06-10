import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'region_obj.dart';

class RegionSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const RegionSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(regionSelectProvider);
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
              return RegionObj(
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
            Navigator.of(context).pop(ref.watch(regionSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
