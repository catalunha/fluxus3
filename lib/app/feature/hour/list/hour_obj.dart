import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/hour_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class HourObj extends StatelessWidget {
  final HourModel model;
  const HourObj({Key? key, required this.model}) : super(key: key);

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
              title: 'Nome: ',
              value: '${model.name}',
            ),
            AppTextTitleValue(
              title: 'Intervalo: ',
              value: '${model.start} às ${model.end}',
            ),
            AppTextTitleValue(
              title: 'Disponível: ',
              value: model.isActive ?? true ? 'Sim' : 'Não',
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.hourSave.name, extra: model.id);
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
