import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/attendance_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class AttendanceObj extends StatelessWidget {
  final AttendanceModel model;
  const AttendanceObj({Key? key, required this.model}) : super(key: key);

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
              title: 'Código da autorização: ',
              value: model.authorizationCode,
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.attendanceSave.name,
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
