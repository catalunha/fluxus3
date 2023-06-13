import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/models/patient_model.dart';
import '../../../core/models/user_profile_model.dart';
import '../../patient/select/patient_select_page.dart';
import '../../user_profile/select/user_profile_select_page.dart';
import '../../utils/app_delete.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class AttendanceSavePage extends ConsumerStatefulWidget {
  final String? id;
  const AttendanceSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AttendanceSavePage> createState() => _AttendanceSavePageState();
}

class _AttendanceSavePageState extends ConsumerState<AttendanceSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _authorizationCodeTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  bool firstTime = true;
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _authorizationCodeTec.text = "";
    _descriptionTec.text = "";
  }

  @override
  void dispose() {
    _authorizationCodeTec.dispose();
    _descriptionTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AttendanceFormState>(attendanceFormProvider,
        (previous, next) async {
      if (next.status == AttendanceFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AttendanceFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == AttendanceFormStatus.loading) {
        showLoader(context);
      }
    });

    final attendanceRead = ref.watch(attendanceReadProvider(id: widget.id));
    final professional = ref.watch(professionalSelectedProvider);
    final procedures = ref.watch(proceduresProvider);
    final patient = ref.watch(patientSelectedProvider);
    final healthPlans = ref.watch(healthPlansProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;

          if (formValid && procedures.isNotEmpty && healthPlans.length == 1) {
            ref.read(attendanceFormProvider.notifier).submitForm(
                  authorizationCode: _authorizationCodeTec.text,
                  description: _descriptionTec.text,
                );
          }
          if (procedures.isEmpty) {
            showMessageError(context, 'Ainda falta pelo menos um procedimento');
          }
          if (healthPlans.length > 1) {
            showMessageError(context, 'Escolha apenas um plano de saúde');
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: attendanceRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(attendanceFormProvider);
            _authorizationCodeTec.text =
                formState.model?.authorizationCode ?? '';
          }
          firstTime = false;
          return Center(
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
                        AppTextFormField(
                          label: 'Descrição do atendimento',
                          controller: _descriptionTec,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Data da criação da autorização:'),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  ref
                                      .watch(authorizationDateCreateProvider
                                          .notifier)
                                      .set(newDate);
                                },
                                child: const Icon(Icons.date_range),
                              ),
                              const SizedBox(width: 10),
                              Text(ref.watch(authorizationDateCreateProvider) !=
                                      null
                                  ? dateFormat.format(ref
                                      .watch(authorizationDateCreateProvider)!)
                                  : "Não informado"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Data da limite da autorização:'),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  ref
                                      .watch(authorizationDateLimitProvider
                                          .notifier)
                                      .set(newDate);
                                },
                                child: const Icon(Icons.date_range),
                              ),
                              const SizedBox(width: 10),
                              Text(ref.watch(authorizationDateLimitProvider) !=
                                      null
                                  ? dateFormat.format(ref
                                      .watch(authorizationDateLimitProvider)!)
                                  : "Não informado"),
                            ],
                          ),
                        ),
                        const Text(
                            '* Selecione o profissional e seus procedimentos'),
                        Row(
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

                                if (result != null) {
                                  ref
                                      .read(
                                          professionalSelectedProvider.notifier)
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
                                      Text('${e.name}'),
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
                                  '${patient.nickname}',
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
                                      Text(
                                          '${e.code} - ${e.healthPlanType?.name}'),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          ref
                                              .read(
                                                  healthPlansProvider.notifier)
                                              .delete(e.id!);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(attendanceFormProvider.notifier).delete();
                          },
                        ),
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
          log('Erro em Lista de atendimentos');
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
