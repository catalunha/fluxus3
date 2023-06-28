import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/healthplan_model.dart';
import '../../../core/models/patient_model.dart';
import '../../../core/models/region_model.dart';
import '../../healthplan/save/healthplan_save_page.dart';
import '../../region/select/region_select_page.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import '../select/patient_select_page.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class PatientSavePage extends ConsumerStatefulWidget {
  final String? id;
  const PatientSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<PatientSavePage> createState() => _PatientSavePageState();
}

class _PatientSavePageState extends ConsumerState<PatientSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _nicknameTec = TextEditingController();
  final _nameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _cpfTec = TextEditingController();
  final _addressTec = TextEditingController();
  bool firstTime = true;
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _nameTec.text = '';
    _emailTec.text = '';
    _nicknameTec.text = '';
    _phoneTec.text = '';
    _cpfTec.text = '';
    _addressTec.text = '';
  }

  @override
  void dispose() {
    _nameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PatientFormState>(patientFormProvider, (previous, next) async {
      if (next.status == PatientFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == PatientFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        // context.pop(); //sai da pagina
        Navigator.pop(context);
      }
      if (next.status == PatientFormStatus.loading) {
        showLoader(context);
      }
    });

    final patientRead = ref.watch(patientReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(patientFormProvider.notifier).submitForm(
                  name: _nameTec.text,
                  email: _emailTec.text,
                  nickname: _nicknameTec.text,
                  phone: _phoneTec.text,
                  cpf: _cpfTec.text,
                  address: _addressTec.text,
                );
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: patientRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(patientFormProvider);
            _emailTec.text = formState.model?.email ?? '';
            _nameTec.text = formState.model?.name ?? '';
            _nicknameTec.text = formState.model?.nickname ?? '';
            _phoneTec.text = formState.model?.phone ?? '';
            _cpfTec.text = formState.model?.cpf ?? '';
            _addressTec.text = formState.model?.address ?? '';
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
                          label: '* Nome completo',
                          controller: _nameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Seu nome curto ou apelido',
                          controller: _nicknameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        const Divider(height: 5),
                        AppTextFormField(
                          label: 'Seu telefone. Formato: DDDNÚMERO',
                          controller: _phoneTec,
                          validator: Validatorless.number(
                              'Apenas números. Formato: DDDNÚMERO'),
                        ),
                        AppTextFormField(
                          label: 'email',
                          controller: _emailTec,
                          validator: Validatorless.email('Email inválido'),
                        ),
                        AppTextFormField(
                          label: 'Seu CPF. Apenas números',
                          controller: _cpfTec,
                          validator: Validatorless.multiple(
                              [Validatorless.cpf('Número de CPF é inválido')]),
                        ),
                        AppTextFormField(
                          label:
                              'Seu endereço completo. (Rua X, ..., CEP ..., )',
                          controller: _addressTec,
                        ),
                        SwitchListTile(
                          title: const Text('É mulher ?'),
                          value: ref.watch(patientIsFemaleProvider),
                          onChanged: (value) {
                            ref.read(patientIsFemaleProvider.notifier).toggle();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Aniversário:'),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  final DateTime? newDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  ref
                                      .watch(birthDayProvider.notifier)
                                      .set(newDate);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.date_range),
                                    const SizedBox(width: 10),
                                    Text(ref.watch(birthDayProvider) != null
                                        ? dateFormat.format(
                                            ref.watch(birthDayProvider)!)
                                        : 'Não informado'),
                                  ],
                                ),
                              ),

                              // IconButton(
                              //     onPressed: () {
                              //       ref
                              //           .watch(birthDayProvider.notifier)
                              //           .set(null);
                              //     },
                              //     icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                        const Text('Selecione a região *'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final RegionModel? result =
                                    await Navigator.of(context)
                                        .push<RegionModel>(MaterialPageRoute(
                                  builder: (context) {
                                    return const RegionSelectPage();
                                  },
                                ));

                                if (result != null) {
                                  log('$result');
                                  ref
                                      .read(regionSelectedProvider.notifier)
                                      .set(result);
                                }
                              },
                              icon: const Icon(Icons.search),
                            ),
                            if (ref.watch(regionSelectedProvider) != null)
                              Flexible(
                                child: Text(
                                  '${ref.watch(regionSelectedProvider)?.uf}-${ref.watch(regionSelectedProvider)?.city}-${ref.watch(regionSelectedProvider)?.name}',
                                  softWrap: true,
                                ),
                              ),
                            if (ref.watch(regionSelectedProvider) != null)
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(regionSelectedProvider.notifier)
                                        .set(null);
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                        ),
                        const Text('Selecione os parentes'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final List<PatientModel>? result =
                                      await Navigator.of(context)
                                          .push<List<PatientModel>?>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const PatientSelectPage(
                                        isSingleValue: false,
                                      );
                                    },
                                  ));

                                  if (result != null) {
                                    for (var element in result) {
                                      ref
                                          .read(
                                              parentsSelectedProvider.notifier)
                                          .update(element);
                                    }
                                  }
                                },
                                icon: const Icon(Icons.search)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ref
                                  .watch(parentsSelectedProvider)
                                  .map(
                                    (e) => Row(
                                      children: [
                                        Text('${e.name}'),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            ref
                                                .read(parentsSelectedProvider
                                                    .notifier)
                                                .update(e);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        const Text('Selecione os planos de saúde'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final HealthPlanModel? result =
                                      await Navigator.of(context)
                                          .push<HealthPlanModel?>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const HealthPlanSavePage(
                                        id: null,
                                      );
                                    },
                                  ));

                                  if (result != null) {
                                    ref
                                        .read(healthPlansSelectedProvider
                                            .notifier)
                                        .add(result);
                                  }
                                },
                                icon: const Icon(Icons.add)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ref
                                  .watch(healthPlansSelectedProvider)
                                  .map(
                                    (e) => Row(
                                      children: [
                                        Text(
                                            '${e.code} - ${e.healthPlanType?.name}'),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            final HealthPlanModel? result =
                                                await Navigator.of(context)
                                                    .push<HealthPlanModel?>(
                                                        MaterialPageRoute(
                                              builder: (context) {
                                                return HealthPlanSavePage(
                                                  id: e.id,
                                                );
                                              },
                                            ));

                                            if (result != null) {
                                              ref
                                                  .read(
                                                      healthPlansSelectedProvider
                                                          .notifier)
                                                  .update(result);
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            ref
                                                .read(
                                                    healthPlansSelectedProvider
                                                        .notifier)
                                                .delete(e.id!);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // AppDelete(
                        //   isVisible: data != null,
                        //   action: () {
                        //     ref.read(patientFormProvider.notifier).delete();
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
