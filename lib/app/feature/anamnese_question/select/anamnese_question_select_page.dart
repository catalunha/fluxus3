import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_question_obj.dart';
import 'controller/providers.dart';

class AnamneseQuestionSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const AnamneseQuestionSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(anamneseQuestionSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'uma pergunta' : 'algumas perguntas'}'),
      ),
      body: list.when(
        data: (data) {
          return Wrap(
            children: [
              for (var hour in data) ...[AnamneseQuestionObj(model: hour)]
            ],
          );
          /*
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return AnamneseQuestionObj(
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
            Navigator.of(context)
                .pop(ref.watch(anamneseQuestionSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
