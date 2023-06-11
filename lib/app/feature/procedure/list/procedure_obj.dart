import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/procedure_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class ProcedureObj extends StatelessWidget {
  final ProcedureModel model;
  const ProcedureObj({Key? key, required this.model}) : super(key: key);

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
              title: 'Codigo: ',
              value: model.code,
            ),
            AppTextTitleValue(
              title: 'Nome: ',
              value: model.name,
            ),
            AppTextTitleValue(
              title: 'Descrição: ',
              value: model.description,
            ),
            AppTextTitleValue(
              title: 'Custo: ',
              value: model.cost.toString(),
            ),
            AppTextTitleValue(
              title: 'Custo Profissional: ',
              value: model.costProf.toString(),
            ),
            AppTextTitleValue(
              title: 'Especialidade: ',
              value: model.expertise?.name,
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.procedureSave.name,
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
