import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/models/attendance_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class AttendanceObj extends StatelessWidget {
  final AttendanceModel model;
  const AttendanceObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');
    final dateFormatHM = DateFormat('dd/MM/y HH:mm');
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
              title: 'Profissional: ',
              value: model.professional?.name,
            ),
            AppTextTitleValue(
              title: 'Profissional: ',
              value: model.professional?.nickname,
            ),
            AppTextTitleValue(
              title: 'Procedimento: ',
              value: model.procedure?.code,
            ),
            AppTextTitleValue(
              title: 'Paciente: ',
              value: model.patient?.nickname,
            ),
            AppTextTitleValue(
              title: 'Plano de saúde id: ',
              value: model.healthPlan?.id,
            ),
            AppTextTitleValue(
              title: 'Plano de saúde code: ',
              value: model.healthPlan?.code,
            ),
            AppTextTitleValue(
              title: 'Plano de saúde tipo: ',
              value: model.healthPlan?.healthPlanType?.name,
            ),
            AppTextTitleValue(
              title: 'Autorização. Código: ',
              value: model.authorizationCode,
            ),
            AppTextTitleValue(
              title: 'Autorização. Criada em: ',
              value: model.authorizationDateCreated == null
                  ? '...'
                  : dateFormat.format(model.authorizationDateCreated!),
            ),
            AppTextTitleValue(
              title: 'Autorização. Limitada a: ',
              value: model.authorizationDateLimit == null
                  ? '...'
                  : dateFormat.format(model.authorizationDateLimit!),
            ),
            AppTextTitleValue(
              title: 'Atendida em: ',
              value: model.attendance == null
                  ? '...'
                  : dateFormatHM.format(model.attendance!),
            ),
            AppTextTitleValue(
              title: 'Presença confirmada em: ',
              value: model.confirmedPresence == null
                  ? '...'
                  : dateFormatHM.format(model.confirmedPresence!),
            ),
            AppTextTitleValue(
              title: 'Status: ',
              value: model.status?.name,
            ),
            ExpansionTile(
              title: const Text('Histórico'),
              children: [
                AppTextTitleValue(
                  title: 'Histórico: ',
                  value: '\n${model.history}',
                  // inColumn: true,
                ),
              ],
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.attendanceEdit.name,
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
