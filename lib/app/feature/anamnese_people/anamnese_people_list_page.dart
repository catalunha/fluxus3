import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_people_obj.dart';
import 'controller/providers.dart';

class AnamnesePeopleListPage extends ConsumerWidget {
  const AnamnesePeopleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final list = ref.watch(anamnesePeopleListProvider);
    final list = ref.watch(anamnesePeopleFilteredProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} anamneses'),
      ),
      body: list.when(
        data: (data) {
          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     final level = data[index];
          //     return AnamnesePeopleObj(
          //       model: level,
          //     );
          //   },
          // );
          return Column(
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'digite parte do nome da criança para busca',
                  ),
                  onChanged: (value) {
                    ref.read(anamnesePeopleSearchProvider.notifier).set(value);
                  },
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final level = data[index];
                    return AnamnesePeopleObj(
                      model: level,
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro em AnamnesePeopleListPage');
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em AnamnesePeopleListPage'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
