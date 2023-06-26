import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_answer_obj.dart';
import 'anamnese_people_print_page.dart';
import 'controller/providers.dart';

class AnamnesePeopleAnswerListPage extends ConsumerWidget {
  const AnamnesePeopleAnswerListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamneseAnswerListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizando respostas'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AnamnesePeoplePrintPage(
                        people: list.requireValue[0].people!,
                        answerList: list.requireValue,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.print))
        ],
      ),
      body: list.when(
        data: (data) {
          if (data.isNotEmpty) {
            var group = data[0].group;
            var listExpansionTile = <Widget>[];
            var listAnswer = <Widget>[];
            for (var answer in data) {
              if (answer.group != group) {
                listExpansionTile.add(ExpansionTile(
                  title: Text(group),
                  children: [...listAnswer],
                ));
                listAnswer.clear();
                group = answer.group;
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
          } else {
            return const Center(
              child: Text('Oops. Sem respostas para esta pesquisa'),
            );
          }
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
