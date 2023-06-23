import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'controller/states.dart';

class AnamneseAnswerSingle extends ConsumerWidget {
  const AnamneseAnswerSingle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .read(answerTypeYesNoProvider.notifier)
                    .set(AnswerTypeYesNoStatus.yes);
              },
              style: ButtonStyle(
                backgroundColor: ref.watch(answerTypeYesNoProvider) ==
                        AnswerTypeYesNoStatus.yes
                    ? const MaterialStatePropertyAll<Color>(Colors.black)
                    : null,
              ),
              child: const Text('Sim'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(answerTypeYesNoProvider.notifier)
                    .set(AnswerTypeYesNoStatus.no);
              },
              style: ButtonStyle(
                backgroundColor: ref.watch(answerTypeYesNoProvider) ==
                        AnswerTypeYesNoStatus.no
                    ? const MaterialStatePropertyAll<Color>(Colors.black)
                    : null,
              ),
              child: const Text('Não'),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            ref
                .read(answerTypeYesNoProvider.notifier)
                .set(AnswerTypeYesNoStatus.none);
          },
          child: const Text('Limpar resposta'),
        ),
      ],
    );
  }
}
