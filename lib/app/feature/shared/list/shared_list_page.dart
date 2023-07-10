import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../save/controller/providers.dart';
import 'controller/states.dart';
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
        title: Text('Lista com ${list.asData?.value.length} informações'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (ref.read(sharedListByStatusStateProvider) ==
                  SharedListByStatus.byOffice ||
              ref.read(sharedListByStatusStateProvider) ==
                  SharedListByStatus.public) {
            ref.read(sharedIsPublicProvider.notifier).set(true);
          } else {
            ref.read(sharedIsPublicProvider.notifier).set(false);
          }
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
