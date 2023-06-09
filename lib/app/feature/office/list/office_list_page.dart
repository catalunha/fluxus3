import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'controller/providers.dart';
import 'office_obj.dart';

class OfficeListPage extends ConsumerWidget {
  const OfficeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(officeListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length ?? "?"} cargos'),
        // title: list.when(
        //   data: (data) {
        //     return Text('Lista com ${data.length} cargos');
        //   },
        //   error: (e, st) {
        //     return null;
        //   },
        //   loading: () {
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.officeSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return OfficeObj(
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
