import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'room_obj2.dart';

class RoomSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const RoomSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(roomSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Selecione ${isSingleValue ? 'uma sala' : 'algumas salas'}'),
      ),
      body: list.when(
        data: (data) {
          return Wrap(
            children: [
              for (var hour in data) ...[RoomObj2(model: hour)]
            ],
          );
          /*
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return RoomObj(
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
            Navigator.of(context).pop(ref.watch(roomSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
