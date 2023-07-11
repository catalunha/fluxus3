import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/models/status_model.dart';
import '../../../routes.dart';
import '../../status/select/status_select_page.dart';
import 'controller/providers.dart';

class AttendanceSearchPage extends ConsumerStatefulWidget {
  const AttendanceSearchPage({super.key});

  @override
  ConsumerState<AttendanceSearchPage> createState() =>
      _AttendanceSearchPageState();
}

class _AttendanceSearchPageState extends ConsumerState<AttendanceSearchPage> {
  // final _authorizationCodeTec = TextEditingController();
  // final _attendanceIdCodeTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    // _authorizationCodeTec.text = '';
    // _attendanceIdCodeTec.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');
    // ref.watch(authorizationCodeSelectedProvider);
    // ref.watch(attendanceIdCodeSelectedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Buscando atendimentos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref
          //     .read(authorizationCodeSelectedProvider.notifier)
          //     .set(_authorizationCodeTec.text);
          // ref
          //     .read(attendanceIdCodeSelectedProvider.notifier)
          //     .set(_attendanceIdCodeTec.text);
          ref.invalidate(attendanceListProvider);
          context.goNamed(AppPage.attendanceList.name);
        },
        child: const Icon(Icons.search),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(children: [
                    const Text('Data da criação da autorização'),
                    Row(
                      children: [
                        Switch(
                            value: ref.watch(dateSelectProvider),
                            onChanged: (value) {
                              ref.read(dateSelectProvider.notifier).set(value);
                            }),
                        Expanded(
                          child: Wrap(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Inicio da busca:'),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate:
                                              ref.watch(startSearchProvider) ??
                                                  DateTime.now(),
                                          firstDate: DateTime(
                                              DateTime.now().year - 100),
                                          lastDate:
                                              DateTime(DateTime.now().year + 1),
                                        );
                                        ref
                                            .watch(startSearchProvider.notifier)
                                            .set(newDate ??
                                                DateTime.now().subtract(
                                                    const Duration(days: 7)));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.date_range),
                                          const SizedBox(width: 10),
                                          Text(dateFormat.format(
                                              ref.watch(startSearchProvider))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Fim da busca:'),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate:
                                              ref.watch(endSearchProvider) ??
                                                  DateTime.now(),
                                          firstDate: DateTime(
                                              DateTime.now().year - 100),
                                          lastDate:
                                              DateTime(DateTime.now().year + 1),
                                        );
                                        ref
                                            .watch(endSearchProvider.notifier)
                                            .set(newDate ??
                                                DateTime.now().add(
                                                    const Duration(days: 15)));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.date_range),
                                          const SizedBox(width: 10),
                                          Text(dateFormat.format(
                                              ref.watch(endSearchProvider))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                // Card(
                //   child: Column(children: [
                //     const Text('Código da autorização'),
                //     Row(
                //       children: [
                //         Switch(
                //             value: ref.watch(authorizationCodeSelectProvider),
                //             onChanged: (value) {
                //               ref
                //                   .read(
                //                       authorizationCodeSelectProvider.notifier)
                //                   .set(value);
                //             }),
                //         Expanded(
                //           child: AppTextFormField(
                //             label: 'Informe o código',
                //             controller: _authorizationCodeTec,
                //           ),
                //         ),
                //       ],
                //     )
                //   ]),
                // ),
                // Card(
                //   child: Column(children: [
                //     const Text('Id do Atendimento'),
                //     Row(
                //       children: [
                //         Switch(
                //             value: ref.watch(attendanceIdCodeSelectProvider),
                //             onChanged: (value) {
                //               ref
                //                   .read(attendanceIdCodeSelectProvider.notifier)
                //                   .set(value);
                //             }),
                //         Expanded(
                //           child: AppTextFormField(
                //             label: 'Informe o código',
                //             controller: _attendanceIdCodeTec,
                //           ),
                //         ),
                //       ],
                //     )
                //   ]),
                // ),
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
                                  final StatusModel? result =
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
                // Card(
                //   child: Column(children: [
                //     const Text('Selecione um Profissional'),
                //     Row(
                //       children: [
                //         Switch(
                //             value: ref.watch(professionalSelectProvider),
                //             onChanged: (value) {
                //               ref
                //                   .read(professionalSelectProvider.notifier)
                //                   .set(value);
                //             }),
                //         Expanded(
                //           child: Row(
                //             children: [
                //               IconButton(
                //                 onPressed: () async {
                //                   final UserProfileModel? result =
                //                       await Navigator.of(context)
                //                           .push<UserProfileModel>(
                //                               MaterialPageRoute(
                //                     builder: (context) {
                //                       return const UserProfileSelectPage();
                //                     },
                //                   ));
                //                   ref
                //                       .read(
                //                           professionalSelectedProvider.notifier)
                //                       .set(result);
                //                 },
                //                 icon: const Icon(Icons.search),
                //               ),
                //               Text(
                //                   '${ref.watch(professionalSelectedProvider)?.nickname}')
                //             ],
                //           ),
                //         ),
                //       ],
                //     )
                //   ]),
                // ),
                // Card(
                //   child: Column(children: [
                //     const Text('Selecione um Procedimento'),
                //     Row(
                //       children: [
                //         Switch(
                //             value: ref.watch(procedureSelectProvider),
                //             onChanged: (value) {
                //               ref
                //                   .read(procedureSelectProvider.notifier)
                //                   .set(value);
                //             }),
                //         Expanded(
                //           child: Row(
                //             children: [
                //               IconButton(
                //                 onPressed: () async {
                //                   final ProcedureModel? result =
                //                       await Navigator.of(context)
                //                           .push<ProcedureModel>(
                //                               MaterialPageRoute(
                //                     builder: (context) {
                //                       return const ProcedureSelectPage();
                //                     },
                //                   ));
                //                   ref
                //                       .read(procedureSelectedProvider.notifier)
                //                       .set(result);
                //                 },
                //                 icon: const Icon(Icons.search),
                //               ),
                //               Text(
                //                   '${ref.watch(procedureSelectedProvider)?.name}')
                //             ],
                //           ),
                //         ),
                //       ],
                //     )
                //   ]),
                // ),
                // Card(
                //   child: Column(children: [
                //     const Text('Selecione um Paciente'),
                //     Row(
                //       children: [
                //         Switch(
                //             value: ref.watch(patientSelectProvider),
                //             onChanged: (value) {
                //               ref
                //                   .read(patientSelectProvider.notifier)
                //                   .set(value);
                //             }),
                //         Expanded(
                //           child: Row(
                //             children: [
                //               IconButton(
                //                 onPressed: () async {
                //                   final PatientModel? result =
                //                       await Navigator.of(context)
                //                           .push<PatientModel>(MaterialPageRoute(
                //                     builder: (context) {
                //                       return const PatientSelectPage();
                //                     },
                //                   ));
                //                   ref
                //                       .read(patientSelectedProvider.notifier)
                //                       .set(result);
                //                 },
                //                 icon: const Icon(Icons.search),
                //               ),
                //               Text(
                //                   '${ref.watch(patientSelectedProvider)?.name}')
                //             ],
                //           ),
                //         ),
                //       ],
                //     )
                //   ]),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
