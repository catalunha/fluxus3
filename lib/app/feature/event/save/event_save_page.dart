import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/attendance_model.dart';
import '../../../core/models/hour_model.dart';
import '../../../core/models/room_model.dart';
import '../../../core/models/status_model.dart';
import '../../attendance/select/attendance_select_page.dart';
import '../../hour/select/hour_select_page.dart';
import '../../room/select/room_select_page.dart';
import '../../status/select/status_select_page.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class EventSavePage extends ConsumerStatefulWidget {
  final String? id;
  const EventSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<EventSavePage> createState() => _EventSavePageState();
}

class _EventSavePageState extends ConsumerState<EventSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _historyTec = TextEditingController();
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _historyTec.text = '';
  }

  @override
  void dispose() {
    _historyTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<EventFormState>(eventFormProvider, (previous, next) async {
      if (next.status == EventFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == EventFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == EventFormStatus.loading) {
        showLoader(context);
      }
      if (next.status == EventFormStatus.overbook) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
    });

    final eventRead = ref.watch(eventReadProvider(id: widget.id));
    final formState = ref.watch(eventFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar evento'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref
                .read(eventFormProvider.notifier)
                .submitForm(history: _historyTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: eventRead.when(
        data: (data) {
          // if (data != null) {
          //   final formState = ref.read(eventFormProvider);
          //   _historyTec.text = formState.model?.history ?? '';
          // }
          return Center(
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Data do evento:'),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  final DateTime? newDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: ref.watch(dayProvider) ??
                                        DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );
                                  ref.watch(dayProvider.notifier).set(newDate);
                                },
                                child: const Icon(Icons.date_range),
                              ),
                              const SizedBox(width: 10),
                              Text(ref.watch(dayProvider) != null
                                  ? dateFormat.format(ref.watch(dayProvider)!)
                                  : 'Não informado'),
                            ],
                          ),
                        ),
                        const Text('Selecione um horário:'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final HourModel? result =
                                    await Navigator.of(context)
                                        .push<HourModel>(MaterialPageRoute(
                                  builder: (context) {
                                    return const HourSelectPage();
                                  },
                                ));

                                ref
                                    .read(hourSelectedProvider.notifier)
                                    .set(result);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            if (ref.watch(hourSelectedProvider) != null)
                              Flexible(
                                child: Text(
                                  '${ref.watch(hourSelectedProvider)!.start} às ${ref.watch(hourSelectedProvider)!.end}',
                                  softWrap: true,
                                ),
                              ),
                            if (ref.watch(hourSelectedProvider) != null)
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(hourSelectedProvider.notifier)
                                        .set(null);
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                        ),
                        const Text('Selecione uma sala'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final RoomModel? result =
                                    await Navigator.of(context)
                                        .push<RoomModel>(MaterialPageRoute(
                                  builder: (context) {
                                    return const RoomSelectPage();
                                  },
                                ));

                                ref
                                    .read(roomSelectedProvider.notifier)
                                    .set(result);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            if (ref.watch(roomSelectedProvider) != null)
                              Flexible(
                                child: Text(
                                  '${ref.watch(roomSelectedProvider)?.name}',
                                  softWrap: true,
                                ),
                              ),
                            if (ref.watch(roomSelectedProvider) != null)
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(roomSelectedProvider.notifier)
                                        .set(null);
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                        ),
                        const Text('Selecione um status'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final StatusModel? result =
                                    await Navigator.of(context)
                                        .push<StatusModel>(MaterialPageRoute(
                                  builder: (context) {
                                    return const StatusSelectPage();
                                  },
                                ));

                                if (result != null) {
                                  log('$result');
                                  ref
                                      .read(statusSelectedProvider.notifier)
                                      .set(result);
                                }
                              },
                              icon: const Icon(Icons.search),
                            ),
                            if (ref.watch(statusSelectedProvider) != null)
                              Flexible(
                                child: Text(
                                  '${ref.watch(statusSelectedProvider)!.name}',
                                  softWrap: true,
                                ),
                              ),
                            if (ref.watch(statusSelectedProvider) != null)
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(statusSelectedProvider.notifier)
                                        .set(null);
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                        ),
                        const Text('Selecione os atendimentos'),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final List<AttendanceModel>? result =
                                      await Navigator.of(context)
                                          .push<List<AttendanceModel>?>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const AttendanceSelectPage(
                                        isSingleValue: false,
                                      );
                                    },
                                  ));

                                  if (result != null) {
                                    for (var element in result) {
                                      ref
                                          .read(attendancesSelectedProvider
                                              .notifier)
                                          .add(element);
                                    }
                                  }
                                },
                                icon: const Icon(Icons.search)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ref
                                  .watch(attendancesSelectedProvider)
                                  .map(
                                    (e) => Row(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text('Id: ${e.id}'),
                                                Text(
                                                  'Prof.: ${e.professional?.nickname}',
                                                ),
                                                Text(
                                                    'Proc.Code: ${e.procedure?.code}'),
                                                Text(
                                                    'Proc.Name: ${e.procedure?.name}'),
                                                Text(
                                                    'Pac.: ${e.patient?.nickname}'),
                                                Text(
                                                    'PlanS. Code: ${e.healthPlan?.code}'),
                                                Text(
                                                    'PlanS Tipo: ${e.healthPlan?.healthPlanType?.name}'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            ref
                                                .read(
                                                    attendancesSelectedProvider
                                                        .notifier)
                                                .delete(e);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        AppTextFormField(
                          label: '* Histórico deste evento',
                          controller: _historyTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória.'),
                        ),
                        ExpansionTile(
                          title: const Text('Histórico'),
                          children: [
                            Text('${formState.model?.history}'),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // AppDelete(
                        //   isVisible: data != null,
                        //   action: () {
                        //     ref.read(eventFormProvider.notifier).delete();
                        //   },
                        // ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          log('tem error');
          log('Erro em Lista de usuarios');
          log('$error');
          log('$stackTrace');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () {
          log('tem loading');

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
