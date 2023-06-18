import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/feature/hour/select/hour_obj2.dart';

import 'controller/providers.dart';

class HourSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const HourSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(hourSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Selecione ${isSingleValue ? 'um cargo' : 'alguns cargos'}'),
      ),
      body: list.when(
        data: (data) {
          return Wrap(
            children: [
              for (var hour in data) ...[HourObj2(model: hour)]
            ],
          );
          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     final level = data[index];
          //     return HourObj(
          //       model: level,
          //       isSingleValue: isSingleValue,
          //     );
          //   },
          // );
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
            Navigator.of(context).pop(ref.watch(hourSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
