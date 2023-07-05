import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'region_obj.dart';

class RegionListPage extends ConsumerWidget {
  const RegionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(regionListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length ?? "?"} regiões'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.regionSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return RegionObj(
              model: level,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em Lista de regiões');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de regiões'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
