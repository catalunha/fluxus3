import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/patient_model.dart';
import '../../../core/models/user_profile_model.dart';
import '../../patient/select/patient_select_page.dart';
import '../../user_profile/select/user_profile_select_page.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class AttendanceAddPage extends ConsumerStatefulWidget {
  final String? id;
  const AttendanceAddPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AttendanceAddPage> createState() => _AttendanceAddPageState();
}

class _AttendanceAddPageState extends ConsumerState<AttendanceAddPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _authorizationCodeTec = TextEditingController();
  final _historyTec = TextEditingController();
  bool firstTime = true;
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _authorizationCodeTec.text = "";
    _historyTec.text = "";
  }

  @override
  void dispose() {
    _authorizationCodeTec.dispose();
    _historyTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AttendanceAddStatus>(attendanceAddStatusStateProvider,
        (previous, next) async {
      if (next == AttendanceAddStatus.error) {
        hideLoader(context);
        showMessageError(context, 'Erro em AttendanceAddPage');
      }
      if (next == AttendanceAddStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next == AttendanceAddStatus.loading) {
        showLoader(context);
      }
    });
    // final formState = ref.watch(attendanceFormProvider);

    final professional = ref.watch(professionalSelectedProvider);
    final procedures = ref.watch(proceduresProvider);
    final patient = ref.watch(patientSelectedProvider);
    final healthPlans = ref.watch(healthPlansProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar atendimento'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;

          if (formValid && procedures.isNotEmpty && healthPlans.length == 1) {
            ref.read(attendanceFormProvider.notifier).submitForm(
                  authorizationCode: _authorizationCodeTec.text,
                  history: _historyTec.text,
                );
          }
          if (procedures.isEmpty) {
            showMessageError(context, 'Ainda falta pelo menos um procedimento');
          }
          if (healthPlans.isEmpty || healthPlans.length > 1) {
            showMessageError(context, 'Escolha apenas um plano de saúde');
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextFormField(
                      label: 'Código da autorização',
                      controller: _authorizationCodeTec,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text('Data da criação da autorização:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              ref
                                  .watch(
                                      authorizationDateCreateProvider.notifier)
                                  .set(newDate ?? DateTime.now());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.date_range),
                                const SizedBox(width: 10),
                                Text(dateFormat.format(ref
                                    .watch(authorizationDateCreateProvider)!)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text('Data da limite da autorização:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    ref.watch(authorizationDateLimitProvider),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime(DateTime.now().year + 1),
                              );
                              ref
                                  .watch(
                                      authorizationDateLimitProvider.notifier)
                                  .set(newDate ??
                                      DateTime.now()
                                          .add(const Duration(days: 30)));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.date_range),
                                const SizedBox(width: 10),
                                Text(
                                  dateFormat.format(ref
                                      .watch(authorizationDateLimitProvider)!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                        '* Selecione o profissional e seus procedimentos'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            UserProfileModel? result =
                                await Navigator.of(context)
                                    .push<UserProfileModel>(MaterialPageRoute(
                              builder: (context) {
                                return const UserProfileSelectPage();
                              },
                            ));

                            if (result != null) {
                              ref
                                  .read(professionalSelectedProvider.notifier)
                                  .set(result);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                        if (professional != null)
                          Flexible(
                            child: Text(
                              '${professional.nickname}',
                              softWrap: true,
                            ),
                          ),
                      ],
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ref
                            .watch(proceduresProvider)
                            .map(
                              (e) => Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.control_point_duplicate),
                                    onPressed: () {
                                      ref
                                          .read(proceduresProvider.notifier)
                                          .duplicate(e.id!);
                                    },
                                  ),
                                  Text('${e.code} - ${e.name}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref
                                          .read(proceduresProvider.notifier)
                                          .delete(e.id!);
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Text('* Selecione o paciente e um plano apenas'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            PatientModel? result = await Navigator.of(context)
                                .push<PatientModel>(MaterialPageRoute(
                              builder: (context) {
                                return const PatientSelectPage();
                              },
                            ));

                            if (result != null) {
                              ref
                                  .read(patientSelectedProvider.notifier)
                                  .set(result);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                        if (patient != null)
                          Flexible(
                            child: Text(
                              '${patient.name}',
                              softWrap: true,
                            ),
                          ),
                      ],
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ref
                            .watch(healthPlansProvider)
                            .map(
                              (e) => Row(
                                children: [
                                  Text('${e.code} - ${e.healthPlanType?.name}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref
                                          .read(healthPlansProvider.notifier)
                                          .delete(e.id!);
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    AppTextFormField(
                      label: '* Histórico deste atendimento',
                      controller: _historyTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória.'),
                    ),
                    // ExpansionTile(
                    //   title: const Text('Histórico'),
                    //   children: [
                    //     Text('${formState.model?.history}'),
                    //   ],
                    // ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
