import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/healthplantype_model.dart';
import '../../healthplantype/select/healthplantype_select_page.dart';
import '../../utils/app_delete.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class HealthPlanSavePage extends ConsumerStatefulWidget {
  final String? id;
  const HealthPlanSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<HealthPlanSavePage> createState() => _HealthPlanSavePageState();
}

class _HealthPlanSavePageState extends ConsumerState<HealthPlanSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _codeTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _codeTec.text = "";
    _descriptionTec.text = "";
  }

  @override
  void dispose() {
    _codeTec.dispose();
    _descriptionTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HealthPlanFormState>(healthPlanFormProvider,
        (previous, next) async {
      if (next.status == HealthPlanFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == HealthPlanFormStatus.success) {
        hideLoader(context);
        context.pop(next.model);
      }
      if (next.status == HealthPlanFormStatus.loading) {
        showLoader(context);
      }
    });

    final healthPlanRead = ref.watch(healthPlanReadProvider(id: widget.id));
    final healthPlanTypeSelected = ref.watch(healthPlanTypeSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid && healthPlanTypeSelected != null) {
            ref.read(healthPlanFormProvider.notifier).submitForm(
                  code: _codeTec.text,
                  description: _descriptionTec.text,
                );
          }
          if (healthPlanTypeSelected == null) {
            showMessageError(context, 'É necessario definir um tipo de plano');
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: healthPlanRead.when(
        data: (data) {
          final formState = ref.read(healthPlanFormProvider);
          if (data != null) {
            _codeTec.text = formState.model?.code ?? '';
            _descriptionTec.text = formState.model?.description ?? '';
          }
          return Center(
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('Selecione o tipo de plano'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                HealthPlanTypeModel? result =
                                    await Navigator.of(context)
                                        .push<HealthPlanTypeModel>(
                                            MaterialPageRoute(
                                  builder: (context) {
                                    return const HealthPlanTypeSelectPage();
                                  },
                                ));

                                if (result != null) {
                                  log('$result');
                                  ref
                                      .read(healthPlanTypeSelectedProvider
                                          .notifier)
                                      .set(result);
                                }
                              },
                              icon: const Icon(Icons.search),
                            ),
                            // if (ref.watch(healthPlanTypeSelectedProvider) != null)
                            //   Flexible(
                            // child:
                            Text(
                              '${healthPlanTypeSelected?.name}',
                              softWrap: true,
                            ),
                            // ),
                          ],
                        ),
                        const Text('Se o plano for particular o código é 1.'),
                        AppTextFormField(
                          label: '* Informe o código do plano',
                          controller: _codeTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: 'Descrição do plano',
                          controller: _descriptionTec,
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(healthPlanFormProvider.notifier).delete();
                          },
                        ),
                        Text('id: ${formState.model?.id}'),
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
