import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/attendance_model.dart';
import '../../../core/models/event_model.dart';
import '../../../core/models/status_model.dart';
import '../../event/save/event_save_page.dart';
import '../../status/select/status_select_page.dart';
import '../confirm_presence/controller/providers.dart';
import '../confirm_presence/schedule_presence.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ScheduleStatus>(scheduleStatusStateProvider,
        (previous, next) async {
      // if (next.status == AttendancePresencFormStatus.error) {
      //   hideLoader(context);
      //   showMessageError(context, next.error);
      // }
      // if (next.status == AttendancePresencFormStatus.success) {
      //   hideLoader(context); //sai do Dialog do loading
      //   Navigator.of(context).pop();
      // }
      // if (next.status == AttendancePresencFormStatus.loading) {
      //   showLoader(context);
      // }
    });

    final dateFormat = DateFormat('dd/MM', 'pt_BR');
    final dateFormatDay = DateFormat('E', 'pt_BR');

    final list = ref.watch(scheduleProvider);
    final eventsFiltered = ref.watch(eventsFilteredProvider);
    final rooms = ref.watch(roomsProvider);
    final roomSelected = ref.watch(roomSelectedProvider);
    final status = ref.watch(statusSelectedProvider);
    // ref.watch(attendancePresencFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda com ${list.asData?.value.length} eventos'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(scheduleProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: list.when(data: (data) {
        // if (eventsFiltered.isEmpty) {
        //   return const Center(child: Text(''));
        // }
        final list = [...eventsFiltered];
        final DateTime start = ref.watch(fistDayProvider);
        final DateTime end = ref.watch(lastDayProvider);

        final List<TimePlannerTask> timePlannerTasks = [];
        final List<TimePlannerTitle> timePlannerHeaders = [];
        int day = 0;
        for (DateTime dayMorning = start;
            dayMorning.isBefore(end.add(const Duration(days: 1)));
            dayMorning = dayMorning.add(const Duration(days: 1))) {
          final DateTime dayNight =
              dayMorning.add(const Duration(hours: 23, minutes: 59));
          timePlannerHeaders.add(
            TimePlannerTitle(
              date: dateFormat.format(dayMorning),
              title: dateFormatDay.format(dayMorning),
            ),
          );
          // log('dayMorning: $dayMorning');
          for (EventModel e in list) {
            // log('event.start: ${e.start}');
            // log('event.end: ${e.end}');

            if (dayMorning.isBefore(e.start!) && dayNight.isAfter(e.end!)) {
              final List<String> texts = [];
              final List<String> tooltipMsgs = [];
              bool allConfirmedPresence = false;
              int confirmedPresence = 0;
              for (AttendanceModel attendance in e.attendances ?? []) {
                if (attendance.confirmedPresence != null) {
                  confirmedPresence++;
                }
                tooltipMsgs.add(
                    '[${attendance.id}] (${attendance.confirmedPresence != null ? "+" : "-"}${attendance.patient?.nickname}, ${attendance.healthPlan?.healthPlanType?.name}, ${attendance.patient?.phone}) {${attendance.professional?.nickname}, ${attendance.procedure?.name}}');
                texts.add('${attendance.professional?.nickname}');
              }
              texts.add('\n$confirmedPresence / ${e.attendances!.length}');
              texts.add('\n${e.id}');
              allConfirmedPresence =
                  confirmedPresence != e.attendances?.length ? false : true;
              // }
              // log('event.start!.hour: ${e.start!.hour}');
              // log('event.start!.minute: ${e.start!.minute}');
              // log('event.start-end: ${e.start!.minute}');
              timePlannerTasks.add(
                TimePlannerTask(
                  key: ValueKey(const Uuid().v4()),
                  color: allConfirmedPresence ? Colors.green : Colors.black,
                  dateTime: TimePlannerDateTime(
                    day: day,
                    hour: e.start!.hour,
                    minutes: e.start!.minute,
                  ),
                  minutesDuration: e.end!.difference(e.start!).inMinutes,
                  // child: Container(
                  //   color: Colors.red,
                  //   child: const Text(
                  //       'aaa bbb ccc ddd eee fff ggg hhh iii jjj kkk lll mmm nnn ooo ppp qqq rrr sss ttt'),
                  // ),
                  child: InkWell(
                    key: ValueKey(const Uuid().v4()),
                    onTap: () async {
                      ref
                          .watch(attendancePresencFormProvider.notifier)
                          .set(e.attendances!);

                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return SchedulePresence(
                            event: e,
                          );
                        },
                      );
                    },
                    onDoubleTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => EventSavePage(id: e.id)),
                      );
                      // ref.invalidate(scheduleProvider);
                    },
                    child: Tooltip(
                        message: tooltipMsgs.join('\n'),
                        child: Text(texts.join(', '))),
                  ),
                  // onTap: () async {
                  //   ref
                  //       .watch(attendancePresencFormProvider.notifier)
                  //       .set(e.attendances!);

                  //   await showDialog(
                  //     barrierDismissible: false,
                  //     context: context,
                  //     builder: (_) {
                  //       return SchedulePresence(
                  //         event: e,
                  //       );
                  //     },
                  //   );
                  // },
                ),
              );
            }
          }
          day++;
        }
        final Widget newPlanner = TimePlanner(
          key: ValueKey(const Uuid().v4()),
          startHour: 7,
          endHour: 19,
          headers: timePlannerHeaders,
          tasks: timePlannerTasks,
          style: TimePlannerStyle(
            // backgroundColor: Colors.blueGrey[900],
            // default value for height is 80
            cellHeight: 120,
            // default value for width is 90
            cellWidth: 120,
            dividerColor: Colors.white,
            showScrollBar: true,
            // horizontalTaskPadding: 5,
            // borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        );
        return Column(
          children: [
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: ref.watch(fistDayProvider),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    ref
                        .watch(fistDayProvider.notifier)
                        .set(newDate ?? DateTime.now());
                    ref.invalidate(scheduleProvider);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 10),
                      Text(dateFormat.format(ref.watch(fistDayProvider)!)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: ref.watch(lastDayProvider),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    ref
                        .watch(lastDayProvider.notifier)
                        .set(newDate ?? DateTime.now());
                    ref.invalidate(scheduleProvider);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 10),
                      Text(dateFormat.format(ref.watch(lastDayProvider)!)),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final StatusModel? result = await Navigator.of(context)
                          .push<StatusModel>(MaterialPageRoute(
                        builder: (context) {
                          return const StatusSelectPage();
                        },
                      ));

                      if (result != null) {
                        log('$result');
                        ref.read(statusSelectedProvider.notifier).set(result);
                      }
                    },
                    child: status.when(data: (data) {
                      return Text(
                        '${data.name}',
                        softWrap: true,
                      );
                    }, error: (e, st) {
                      log('$e');
                      log('$e');
                      return const Text('Oops');
                    }, loading: () {
                      return const Text('...');
                    })
                    // child: Text(
                    //   '${status.name}',
                    //   softWrap: true,
                    // ),
                    ),
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () async {
                //         StatusModel? result = await Navigator.of(context)
                //             .push<StatusModel>(MaterialPageRoute(
                //           builder: (context) {
                //             return const StatusSelectPage();
                //           },
                //         ));

                //         if (result != null) {
                //           log('$result');
                //           ref.read(statusSelectedProvider.notifier).set(result);
                //         }
                //       },
                //       icon: const Icon(Icons.search),
                //     ),
                //     Flexible(
                //       child: Text(
                //         '${ref.watch(statusSelectedProvider)!.name}',
                //         softWrap: true,
                //       ),
                //     ),
                //     // if (ref.watch(statusSelectedProvider) != null)
                //     //   IconButton(
                //     //       onPressed: () {
                //     //         ref
                //     //             .read(statusSelectedProvider.notifier)
                //     //             .set(null);
                //     //       },
                //     //       icon: const Icon(Icons.delete))
                //   ],
                // ),
                for (var room in rooms) ...[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: room == roomSelected ? Colors.green : null,
                    child: IconButton(
                      icon: Text('${room.name}'),
                      onPressed: () {
                        ref.read(roomSelectedProvider.notifier).set(room);
                        ref.read(eventsFilteredProvider.notifier).filter();
                      },
                    ),
                  )
                ],
              ],
            ),
            Expanded(child: newPlanner),
          ],
        );
      }, error: (error, stackTrace) {
        log('Erro em construir agenda');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em construir agenda'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => const EventSavePage(
                      id: null,
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
