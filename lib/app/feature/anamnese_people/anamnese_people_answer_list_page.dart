import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_answer_obj.dart';
import 'controller/providers.dart';

class AnamnesePeopleAnswerListPage extends ConsumerWidget {
  const AnamnesePeopleAnswerListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamneseAnswerListProvider);
    var group = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizando respostas'),
      ),
      body: list.when(
        data: (data) {
          var group = data[0].question!.anamneseGroup.name;
          var listExpansionTile = <Widget>[];
          var listAnswer = <Widget>[];
          for (var answer in data) {
            if (answer.question!.anamneseGroup.name != group) {
              listExpansionTile.add(ExpansionTile(
                title: Text(group),
                children: [...listAnswer],
              ));
              listAnswer.clear();
              group = answer.question!.anamneseGroup.name;
              listAnswer.add(AnamneseAnswerObj(
                model: answer,
              ));
            } else {
              listAnswer.add(AnamneseAnswerObj(
                model: answer,
              ));
            }
          }
          listExpansionTile.add(ExpansionTile(
            title: Text(group),
            children: [...listAnswer],
          ));
          return SingleChildScrollView(
            child: Column(children: listExpansionTile),
          );

          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     final answer = data[index];

          //     return AnamneseAnswerObj(
          //       model: answer,
          //     );
          //   },
          // );
        },
        error: (error, stackTrace) {
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em AnamnesePeoplePrintReadPage'),
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
