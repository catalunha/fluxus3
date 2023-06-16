import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';

import '../../../core/models/attendance_model.dart';
import '../../../core/models/event_model.dart';
import 'controller/providers.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd/MM/y', 'pt_BR');
    final dateFormatDay = DateFormat('E', 'pt_BR');

    final list = ref.watch(scheduleProvider);
    final eventsFiltered = ref.watch(eventsFilteredProvider);
    final rooms = ref.watch(roomsProvider);
    final roomSelected = ref.watch(roomSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos encontrados'),
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
              if (e.attendances?.length == 1) {
                for (AttendanceModel attendance in e.attendances ?? []) {
                  texts.add('${attendance.professional?.nickname}');
                  texts.add('${attendance.patient?.nickname}');
                  allConfirmedPresence =
                      attendance.confirmedPresence == null ? false : true;
                }
              } else {
                int confirmedPresence = 0;
                for (AttendanceModel attendance in e.attendances ?? []) {
                  if (attendance.confirmedPresence != null) {
                    confirmedPresence++;
                  }
                  tooltipMsgs.add(
                      '${attendance.confirmedPresence != null ? "+" : "-"}${attendance.professional?.nickname} (${attendance.procedure?.code}) - ${attendance.patient?.nickname} ( ${attendance.healthPlan?.healthPlanType?.name}) ${attendance.patient?.phone}');
                  texts.add(
                      '${attendance.confirmedPresence != null ? "+" : "-"}${attendance.professional?.nickname}');
                }
                texts.add(
                    '$confirmedPresence/${e.attendances?.length} Cfm/Ats. ');
                allConfirmedPresence =
                    confirmedPresence != e.attendances?.length ? false : true;
              }
              timePlannerTasks.add(
                TimePlannerTask(
                  color: allConfirmedPresence ? Colors.green : Colors.black,
                  dateTime: TimePlannerDateTime(
                    day: day,
                    hour: dateTimeStart.hour,
                    minutes: dateTimeStart.minute,
                  ),
                  minutesDuration: 40,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => BlocProvider.value(
                      //       value: BlocProvider.of<ScheduleSearchBloc>(context),
                      //       child: EventAddPage(model: e),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Tooltip(
                        message: tooltipMsgs.join('\n'),
                        child: Text(texts.join('\n'))),
                  ),
                  onTap: () async {
                    // await showDialog(
                    //   barrierDismissible: false,
                    //   context: context,
                    //   builder: (_) {
                    //     return ;
                    //     // return ScheduleConfirmAttendancePage(
                    //     //     models: models);

                    //     // return BlocProvider.value(
                    //     //   value: BlocProvider.of<ScheduleSearchBloc>(
                    //     //       context),
                    //     //   child: ScheduleConfirmAttendancePage(event: e),
                    //     // );
                    //   },
                    // );
                  },
                ),
              );
            }
          }
          day++;
        }
        Widget newPlanner = TimePlanner(
          key: ValueKey(eventsFiltered.hashCode),
          startHour: 7,
          endHour: 19,
          headers: timePlannerHeaders,
          tasks: timePlannerTasks,
        );
        return Column(
          children: [
            Wrap(
              children: [
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
                ]
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
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => BlocProvider.value(
          //       value: BlocProvider.of<ScheduleSearchBloc>(context),
          //       child: const EventAddPage(model: null),
          //     ),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
