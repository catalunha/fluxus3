import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search/controller/providers.dart';
import 'event_obj.dart';

class EventListPage extends ConsumerWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(eventListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de eventos'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.goNamed(AppPage.eventE.name, extra: null);
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return EventObj(
              model: level,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em Lista de cargos');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de cargos'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
