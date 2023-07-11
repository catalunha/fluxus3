import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/attendance_model.dart';
import '../../utils/app_text_title_value.dart';
import 'controller/providers.dart';

class AttendanceObj extends ConsumerWidget {
  final AttendanceModel model;
  final bool isSingleValue;

  const AttendanceObj(
      {Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final attendanceSelected = ref.watch(attendanceSelectedProvider);
    if (attendanceSelected.contains(model)) {
      color = Colors.green;
    }
    return InkWell(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextTitleValue(
                title: 'Id: ',
                value: model.id,
              ),
              AppTextTitleValue(
                title: 'Codigo de autorização: ',
                value: model.authorizationCode,
              ),
              AppTextTitleValue(
                title: 'Profissional: ',
                value: model.professional?.name,
              ),
              AppTextTitleValue(
                title: 'Paciente: ',
                value: model.patient?.name,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (isSingleValue) {
          Navigator.of(context).pop(model);
        } else {
          ref.watch(attendanceSelectedProvider.notifier).toggle(model);
        }
      },
    );

    // return Card(
    //   child: ListTile(
    //     title: Text('${model.authorizationCode}'),
    //     subtitle: Text('${model.id}'),
    //     tileColor: color,
    //     onTap: () {
    //       if (isSingleValue) {
    //         Navigator.of(context).pop(model);
    //       } else {
    //         ref.watch(attendanceSelectedProvider.notifier).toggle(model);
    //       }
    //     },
    //   ),
    // );
  }
}
