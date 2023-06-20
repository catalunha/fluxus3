import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/anamnese_question_model.dart';
import 'controller/providers.dart';

class AnamneseQuestionObj extends ConsumerWidget {
  final AnamneseQuestionModel model;
  final bool isSingleValue;

  const AnamneseQuestionObj(
      {Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final anamneseQuestionselected =
        ref.watch(anamneseQuestionSelectedProvider);
    if (anamneseQuestionselected.contains(model)) {
      color = Colors.green;
    }
    return Card(
      child: ListTile(
        title: Text(model.text),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(anamneseQuestionSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
