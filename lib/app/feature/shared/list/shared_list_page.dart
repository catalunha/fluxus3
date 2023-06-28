import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared_obj.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';

class SharedListPage extends ConsumerWidget {
  const SharedListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(sharedListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} descrições'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.sharedSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final model = data[index];
            return SharedObj(
              model: model,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em SharedListPage');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em SharedListPage'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
