import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/models/patient_model.dart';
import '../../../core/models/procedure_model.dart';
import '../../../core/models/status_model.dart';
import '../../../core/models/user_profile_model.dart';
import '../../../routes.dart';
import '../../patient/select/patient_select_page.dart';
import '../../procedure/select/procedure_select_page.dart';
import '../../status/select/status_select_page.dart';
import '../../user_profile/select/user_profile_select_page.dart';
import 'controller/providers.dart';

class EventSearchPage extends ConsumerWidget {
  const EventSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd/MM/y');

    return Scaffold(
      appBar: AppBar(title: const Text('Buscando atendimentos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(eventListProvider);
          context.goNamed(AppPage.eventList.name);
        },
        child: const Icon(Icons.search),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Inicio da busca:'),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: ref.watch(startSearchProvider) ??
                                DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          ref.watch(startSearchProvider.notifier).set(newDate ??
                              DateTime.now().subtract(const Duration(days: 7)));
                        },
                        child: const Icon(Icons.date_range),
                      ),
                      const SizedBox(width: 10),
                      Text(dateFormat.format(ref.watch(startSearchProvider))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Fim da busca:'),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate:
                                ref.watch(endSearchProvider) ?? DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          ref.watch(endSearchProvider.notifier).set(newDate ??
                              DateTime.now().add(const Duration(days: 15)));
                        },
                        child: const Icon(Icons.date_range),
                      ),
                      const SizedBox(width: 10),
                      Text(dateFormat.format(ref.watch(endSearchProvider))),
                    ],
                  ),
                ),
                Card(
                  child: Column(children: [
                    const Text('Selecione um Status'),
                    Row(
                      children: [
                        Switch(
                            value: ref.watch(statusSelectProvider),
                            onChanged: (value) {
                              ref
                                  .read(statusSelectProvider.notifier)
                                  .set(value);
                            }),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  StatusModel? result =
                                      await Navigator.of(context)
                                          .push<StatusModel>(MaterialPageRoute(
                                    builder: (context) {
                                      return const StatusSelectPage();
                                    },
                                  ));
                                  ref
                                      .read(statusSelectedProvider.notifier)
                                      .set(result);
                                },
                                icon: const Icon(Icons.search),
                              ),
                              Text('${ref.watch(statusSelectedProvider)?.name}')
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                Card(
                  child: Column(children: [
                    const Text('Selecione um Profissional'),
                    Row(
                      children: [
                        Switch(
                            value: ref.watch(professionalSelectProvider),
                            onChanged: (value) {
                              ref
                                  .read(professionalSelectProvider.notifier)
                                  .set(value);
                            }),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  UserProfileModel? result =
                                      await Navigator.of(context)
                                          .push<UserProfileModel>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const UserProfileSelectPage();
                                    },
                                  ));
                                  ref
                                      .read(
                                          professionalSelectedProvider.notifier)
                                      .set(result);
                                },
                                icon: const Icon(Icons.search),
                              ),
                              Text(
                                  '${ref.watch(professionalSelectedProvider)?.nickname}')
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                Card(
                  child: Column(children: [
                    const Text('Selecione um Procedimento'),
                    Row(
                      children: [
                        Switch(
                            value: ref.watch(procedureSelectProvider),
                            onChanged: (value) {
                              ref
                                  .read(procedureSelectProvider.notifier)
                                  .set(value);
                            }),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  ProcedureModel? result =
                                      await Navigator.of(context)
                                          .push<ProcedureModel>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const ProcedureSelectPage();
                                    },
                                  ));
                                  ref
                                      .read(procedureSelectedProvider.notifier)
                                      .set(result);
                                },
                                icon: const Icon(Icons.search),
                              ),
                              Text(
                                  '${ref.watch(procedureSelectedProvider)?.name}')
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                Card(
                  child: Column(children: [
                    const Text('Selecione um Paciente'),
                    Row(
                      children: [
                        Switch(
                            value: ref.watch(patientSelectProvider),
                            onChanged: (value) {
                              ref
                                  .read(patientSelectProvider.notifier)
                                  .set(value);
                            }),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  PatientModel? result =
                                      await Navigator.of(context)
                                          .push<PatientModel>(MaterialPageRoute(
                                    builder: (context) {
                                      return const PatientSelectPage();
                                    },
                                  ));
                                  ref
                                      .read(patientSelectedProvider.notifier)
                                      .set(result);
                                },
                                icon: const Icon(Icons.search),
                              ),
                              Text(
                                  '${ref.watch(patientSelectedProvider)?.name}')
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
