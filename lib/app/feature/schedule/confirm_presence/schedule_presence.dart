import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/feature/schedule/confirm_presence/controller/providers.dart';

import '../../../core/models/event_model.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import 'controller/states.dart';

class SchedulePresence extends ConsumerWidget with Loader, Messages {
  final EventModel event;
  SchedulePresence({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AttendancePresencFormState>(attendancePresencFormProvider,
        (previous, next) async {
      if (next.status == AttendancePresencFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AttendancePresencFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        Navigator.of(context).pop();
      }
      if (next.status == AttendancePresencFormStatus.loading) {
        showLoader(context);
      }
    });
    ref.watch(attendancePresencFormProvider);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Confirmação de presenças'),
            Column(
              children: event.attendances!
                  .map(
                    (attendance) => SwitchListTile(
                        title: Text(
                            '${attendance.patient?.nickname}, ${attendance.healthPlan?.healthPlanType?.name}, ${attendance.patient?.phone}.'),
                        subtitle: Text(
                            '${attendance.professional?.nickname}, ${attendance.procedure?.name}.'),
                        value: ref
                            .watch(attendancePresencFormProvider.notifier)
                            .contains(attendance),
                        onChanged: (value) {
                          if (value) {
                            ref
                                .read(attendancePresencFormProvider.notifier)
                                .add(attendance);
                          } else {
                            ref
                                .read(attendancePresencFormProvider.notifier)
                                .remove(attendance);
                          }
                        }),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 50),
                TextButton(
                  onPressed: () async {
                    ref.read(attendancePresencFormProvider.notifier).confirm();
                  },
                  child: const Text('Atualizar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
