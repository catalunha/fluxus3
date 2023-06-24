import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/anamnese_people_model.dart';
import '../utils/app_text_title_value.dart';

class AnamnesePeopleObj extends StatelessWidget {
  final AnamnesePeopleModel model;
  const AnamnesePeopleObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');
    final childBirthDate =
        AgeCalculator.age(model.childBirthDate, today: DateTime.now());
    final createdAt =
        AgeCalculator.age(model.createdAt!, today: DateTime.now());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextTitleValue(
              title: 'Data da Entrevista: ',
              value:
                  '${dateFormat.format(model.createdAt!)} - ${createdAt.years} a, ${createdAt.months} m, ${createdAt.days} d',
            ),
            const Text('Dados do adulto:'),
            AppTextTitleValue(
              title: 'Nome: ',
              value: model.adultName,
            ),
            AppTextTitleValue(
              title: 'Celular: ',
              value: model.adultPhone,
            ),
            const Text('Dados da criança:'),
            AppTextTitleValue(
              title: 'A criança é: ',
              value: model.childIsFemale ? "MeninA" : "MeninO",
            ),
            AppTextTitleValue(
              title: 'Nascimento: ',
              value:
                  '${dateFormat.format(model.childBirthDate)} - ${childBirthDate.years} a, ${childBirthDate.months} m, ${childBirthDate.days} d',
            ),
          ],
        ),
      ),
    );
  }
}
