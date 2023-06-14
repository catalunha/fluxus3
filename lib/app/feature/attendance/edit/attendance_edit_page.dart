import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/status_model.dart';
import '../../status/select/status_select_page.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class AttendanceEditPage extends ConsumerStatefulWidget {
  final String? id;
  const AttendanceEditPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AttendanceEditPage> createState() => _AttendanceEditPageState();
}

class _AttendanceEditPageState extends ConsumerState<AttendanceEditPage>
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
    final formState = ref.watch(attendanceFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;

          if (formValid) {
            ref.read(attendanceFormProvider.notifier).submitForm(
                  authorizationCode: _authorizationCodeTec.text,
                  history: _historyTec.text,
                );
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: attendanceRead.when(
        data: (data) {
          if (data != null && firstTime) {
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
                                    initialDate: ref.watch(
                                            authorizationDateCreateProvider) ??
                                        DateTime.now(),
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
                                    initialDate: ref.watch(
                                            authorizationDateLimitProvider) ??
                                        DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime(DateTime.now().year + 1),
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
                        const Text('* Profissional e o procedimento'),
                        Text('${formState.model?.professional?.nickname}'),
                        Text('${formState.model?.procedure?.name}'),
                        const Text('* Paciente e plano'),
                        Text('${formState.model?.patient?.nickname}'),
                        Text(
                            '${formState.model?.healthPlan?.code}-${formState.model?.healthPlan?.healthPlanType?.name}'),
                        const SizedBox(height: 15),
                        const Text('Selecione um status'),
                        Row(
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
                        AppTextFormField(
                          label: '* Histórico deste atendimento',
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
                        // AppDelete(
                        //   isVisible: data != null,
                        //   action: () {
                        //     ref.read(attendanceFormProvider.notifier).delete();
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
