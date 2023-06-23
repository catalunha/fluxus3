import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';

class AnamneseAnswerText extends ConsumerStatefulWidget {
  const AnamneseAnswerText({super.key});

  @override
  ConsumerState<AnamneseAnswerText> createState() => _AnamneseAnswerTextState();
}

class _AnamneseAnswerTextState extends ConsumerState<AnamneseAnswerText> {
  final _txtTec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _txtTec,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            maxLines: 3,
            onChanged: (value) {
              ref.read(answerTextProvider.notifier).set(value);
            },
          ),
          TextButton(
            onPressed: () {
              _txtTec.text = '';
              ref.read(answerTextProvider.notifier).set('');
            },
            child: const Text('Limpar resposta'),
          ),
          Text(ref.watch(answerTextProvider))
        ],
      ),
    );
  }
}
