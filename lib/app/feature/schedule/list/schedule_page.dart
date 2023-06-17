import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/attendance_model.dart';
import '../../../core/models/event_model.dart';
import '../../event/add/event_add_page.dart';
import '../confirm_presence/controller/providers.dart';
import '../confirm_presence/schedule_presence.dart';
import 'controller/providers.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd/MM', 'pt_BR');
    final dateFormatDay = DateFormat('E', 'pt_BR');

    final list = ref.watch(scheduleProvider);
    final eventsFiltered = ref.watch(eventsFilteredProvider);
    final rooms = ref.watch(roomsProvider);
    final roomSelected = ref.watch(roomSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos encontrados'),
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
        var list = [...eventsFiltered];
        DateTime start = ref.watch(fistDayProvider);
        DateTime end = ref.watch(lastDayProvider);

        List<TimePlannerTask> timePlannerTasks = [];
        List<TimePlannerTitle> timePlannerHeaders = [];
        int day = 0;
        for (DateTime dayMorning = start;
            dayMorning.isBefore(end.add(const Duration(days: 1)));
            dayMorning = dayMorning.add(const Duration(days: 1))) {
          DateTime dayNight =
              dayMorning.add(const Duration(hours: 23, minutes: 59));
          timePlannerHeaders.add(
            TimePlannerTitle(
              date: dateFormat.format(dayMorning),
              title: dateFormatDay.format(dayMorning),
            ),
          );
          print('list: ${list.length}');
          print('roomSelected: $roomSelected');
          for (EventModel e in list) {
            final hourStartList =
                e.hour!.start!.split(':').map((e) => int.parse(e)).toList();
            final dateTimeStart = e.day!.add(
                Duration(hours: hourStartList[0], minutes: hourStartList[1]));
            if (dayMorning.isBefore(dateTimeStart) &&
                dayNight.isAfter(dateTimeStart)) {
              List<String> texts = [];
              List<String> tooltipMsgs = [];
              bool allConfirmedPresence = false;
              // if (e.attendances?.length == 1) {
              //   for (AttendanceModel attendance in e.attendances ?? []) {
              //     texts.add('${attendance.professional?.nickname}');
              //     texts.add('${attendance.patient?.nickname}');
              //     allConfirmedPresence =
              //         attendance.confirmedPresence == null ? false : true;
              //   }
              // } else {
              int confirmedPresence = 0;
              for (AttendanceModel attendance in e.attendances ?? []) {
                if (attendance.confirmedPresence != null) {
                  confirmedPresence++;
                }
                tooltipMsgs.add(
                    '${attendance.confirmedPresence != null ? "+" : "-"}${attendance.patient?.nickname}, ${attendance.healthPlan?.healthPlanType?.name}, ${attendance.patient?.phone}. ${attendance.professional?.nickname}, ${attendance.procedure?.name}.');
                texts.add('${attendance.professional?.nickname}');
              }
              texts
                  .add('\n$confirmedPresence / ${e.attendances!.length} P/A. ');
              allConfirmedPresence =
                  confirmedPresence != e.attendances?.length ? false : true;
              // }
              timePlannerTasks.add(
                TimePlannerTask(
                  color: allConfirmedPresence ? Colors.green : Colors.black,
                  dateTime: TimePlannerDateTime(
                    day: day,
                    hour: dateTimeStart.hour,
                    minutes: dateTimeStart.minute,
                  ),
                  minutesDuration: 40,
                  // child: Container(
                  //   color: Colors.red,
                  //   child: const Text(
                  //       'aaa bbb ccc ddd eee fff ggg hhh iii jjj kkk lll mmm nnn ooo ppp qqq rrr sss ttt'),
                  // ),
                  child: Tooltip(
                      message: tooltipMsgs.join('\n'),
                      child: Text(texts.join(', '))),
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
                ),
              );
            }
          }
          day++;
        }
        Widget newPlanner = TimePlanner(
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
                    DateTime? newDate = await showDatePicker(
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
                    DateTime? newDate = await showDatePicker(
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EventAddPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
