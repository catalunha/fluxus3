import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/event_model.dart';
import '../../../routes.dart';
import '../../utils/app_datetime_value.dart';
import '../../utils/app_text_title_value.dart';
import '../save/event_save_page.dart';

class EventObj extends StatelessWidget {
  final EventModel model;
  const EventObj({Key? key, required this.model}) : super(key: key);

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
            AppDateTimeValue(
              title: 'Inicio: ',
              value: model.start,
            ),
            AppDateTimeValue(
              title: 'Fim: ',
              value: model.end,
            ),
            AppTextTitleValue(
              title: 'Sala: ',
              value: '${model.room?.name}',
            ),
            AppTextTitleValue(
              title: 'Status: ',
              value: '${model.status?.name}',
            ),
            const Text('Atendimentos:'),
            ExpansionTile(
              title: const Text('Atendimentos'),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.attendances!
                      .map(
                        (e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Id: ${e.id}'),
                                Text('Prof.: ${e.professional?.nickname}'),
                                Text('Proc.: ${e.procedure?.code}'),
                                Text('Pac.: ${e.patient?.nickname}'),
                                Text('PS: ${e.healthPlan?.code}'),
                                Text(
                                    'PS Tipo: ${e.healthPlan?.healthPlanType?.name}'),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
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
                    context.goNamed(AppPage.eventSave.name, extra: model.id);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return EventSavePage(id: model.id);
                      },
                    ));
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
