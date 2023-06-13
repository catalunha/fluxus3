import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/attendance_model.dart';
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
    return Card(
      child: ListTile(
        title: Text('${model.authorizationCode}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(attendanceSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
