import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/feature/anamnese/controller/providers.dart';

import 'anamnese_text.dart';

class AnamneseAnswerPage extends ConsumerWidget {
  const AnamneseAnswerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(readAllQuestionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pergunta'),
      ),
      body: questions.when(
        data: (data) {
          return const Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnamneseText(),
                ],
              ),
            ),
          );
        },
        error: (error, st) {
          return const Text('Erro em listar perguntas');
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
