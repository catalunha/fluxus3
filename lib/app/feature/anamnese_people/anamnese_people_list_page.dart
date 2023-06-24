import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_people_obj.dart';
import 'controller/providers.dart';

class AnamnesePeopleListPage extends ConsumerWidget {
  const AnamnesePeopleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamnesePeopleListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} anamneses'),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return AnamnesePeopleObj(
              model: level,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em AnamnesePeopleListPage');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em AnamnesePeopleListPage'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
