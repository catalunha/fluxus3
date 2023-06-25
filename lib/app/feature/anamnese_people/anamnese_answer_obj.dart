import 'package:flutter/material.dart';

import '../../core/models/anamnese_answer_model.dart';
import '../utils/app_text_title_value.dart';

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
          Text(model.question!.text),
          // if (model.answerBool != null) Text(model.answerBool! ? "Sim" : "Não"),
          // if (model.answerText != null) Text(model.answerText!),
          if (model.answerBool != null)
            AppTextTitleValue(
              title: 'Resposta: ',
              value: model.answerBool! ? "Sim" : "Não",
            ),
          if (model.answerText != null)
            AppTextTitleValue(
              title: 'Resposta: ',
              value: model.answerText,
            ),
        ],
      ),
    );
  }
}
