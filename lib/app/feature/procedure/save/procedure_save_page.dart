import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/expertise_model.dart';
import '../../expertise/select/expertise_select_page.dart';
import '../../utils/app_delete.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class ProcedureSavePage extends ConsumerStatefulWidget {
  final String? id;
  const ProcedureSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProcedureSavePage> createState() => _ProcedureSavePageState();
}

class _ProcedureSavePageState extends ConsumerState<ProcedureSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _codeTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  final _costTec = TextEditingController();
  final _costProfTec = TextEditingController();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _nameTec.text = '';
    _codeTec.text = '';
    _descriptionTec.text = '';
    _costTec.text = '';
    _costProfTec.text = '';
  }

  @override
  void dispose() {
    _nameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ProcedureFormState>(procedureFormProvider,
        (previous, next) async {
      if (next.status == ProcedureFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == ProcedureFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == ProcedureFormStatus.loading) {
        showLoader(context);
      }
    });

    final procedureRead = ref.watch(procedureReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      body: procedureRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(procedureFormProvider);
            _nameTec.text = formState.model?.name ?? '';
            _codeTec.text = formState.model?.code ?? '';
            _descriptionTec.text = formState.model?.description ?? '';
            _costTec.text = formState.model?.cost?.toString() ?? '';
            _costProfTec.text = formState.model?.costProf?.toString() ?? '';
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
                          label: '* Codigo',
                          controller: _codeTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Nome curto',
                          controller: _nameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Descrição',
                          controller: _descriptionTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                          maxLines: 5,
                        ),
                        AppTextFormField(
                          label: 'Custo para proclinica',
                          controller: _costTec,
                          validator: Validatorless.number(
                              'Esta informação é numérica'),
                        ),
                        AppTextFormField(
                          label: 'Custo para o profissional',
                          controller: _costProfTec,
                          validator: Validatorless.number(
                              'Esta informação é numérica'),
                        ),
                        const SizedBox(height: 15),
                        const Text('Selecione as especialidades'),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final ExpertiseModel? result =
                                      await Navigator.of(context)
                                          .push<ExpertiseModel?>(
                                              MaterialPageRoute(
                                    builder: (context) {
                                      return const ExpertiseSelectPage(
                                        isSingleValue: true,
                                      );
                                    },
                                  ));

                                  if (result != null) {
                                    ref
                                        .read(
                                            expertiseSelectedProvider.notifier)
                                        .set(result);
                                  }
                                },
                                icon: const Icon(Icons.search)),
                            Flexible(
                              child: Text(
                                  '${ref.watch(expertiseSelectedProvider)?.name}'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(expertiseSelectedProvider.notifier)
                                    .set(null);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(procedureFormProvider.notifier).delete();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          final expertise = ref.read(expertiseSelectedProvider);

          if (formValid && expertise != null) {
            ref.read(procedureFormProvider.notifier).submitForm(
                  name: _nameTec.text,
                  code: _codeTec.text,
                  description: _descriptionTec.text,
                  cost: _costTec.text,
                  costProf: _costProfTec.text,
                );
          }
          if (expertise == null) {
            showMessageError(context, 'Por favor informe uma especialidade.');
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
    );
  }
}
