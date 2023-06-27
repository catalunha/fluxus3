import 'package:flutter/material.dart';

import '../../core/models/anamnese_answer_model.dart';

class AnamneseAnswerObj extends StatelessWidget {
  final AnamneseAnswerModel model;
  const AnamneseAnswerObj({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Text(model.id!),
          // AppTextTitleValue(
          //   title: 'Grupo: ',
          //   value: model.question!.anamneseGroup.name,
          // ),
          // AppTextTitleValue(
          //   title: 'Pergunta: ',
          //   value: model.question!.text,
          // ),
          // Text(model.question!.anamneseGroup.name),
          Text(model.text),
          // if (model.answerBool != null) Text(model.answerBool! ? "Sim" : "Não"),
          // if (model.answerText != null) Text(model.answerText!),
          Text(model.answers.join(",")),
        ],
      ),
    );
  }
}
