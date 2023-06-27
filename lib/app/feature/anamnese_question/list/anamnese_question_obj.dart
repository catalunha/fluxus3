import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/anamnese_question_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class AnamneseQuestionObj extends StatelessWidget {
  final AnamneseQuestionModel model;
  const AnamneseQuestionObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextTitleValue(
              title: 'Id: ',
              value: model.id,
            ),
            AppTextTitleValue(
              title: 'Texto: ',
              value: model.text,
            ),
            AppTextTitleValue(
              title: 'Tipo: ',
              value: model.type,
            ),
            AppTextTitleValue(
              title: 'Opções: ',
              value: model.options.join(','),
            ),
            AppTextTitleValue(
              title: 'Obrigatória: ',
              value: model.isRequired ? "Sim" : "Não",
            ),
            AppTextTitleValue(
              title: 'Grupo: ',
              value: model.group.name,
            ),
            AppTextTitleValue(
              title: 'Ativa: ',
              value: model.isActive ? "Sim" : "Não",
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.anamneseQuestionSave.name,
                        extra: model.id);
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
