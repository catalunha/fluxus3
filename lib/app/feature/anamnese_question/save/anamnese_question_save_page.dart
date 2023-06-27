import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/models/anamnese_group_model.dart';
import '../../anamnese_group/select/anamnese_group_select_page.dart';
import '../../utils/app_delete.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'type_mark.dart';

class AnamneseQuestionSavePage extends ConsumerStatefulWidget {
  final String? id;
  const AnamneseQuestionSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AnamneseQuestionSavePage> createState() =>
      _AnamneseQuestionSavePageState();
}

class _AnamneseQuestionSavePageState
    extends ConsumerState<AnamneseQuestionSavePage> with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _textTec = TextEditingController();
  final _optionsTec = TextEditingController();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _textTec.text = "";
    _optionsTec.text = "Sim,Não";
  }

  @override
  void dispose() {
    _textTec.dispose();
    _optionsTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AnamneseQuestionFormState>(anamneseQuestionFormProvider,
        (previous, next) async {
      if (next.status == AnamneseQuestionFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AnamneseQuestionFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == AnamneseQuestionFormStatus.loading) {
        showLoader(context);
      }
    });

    final anamneseQuestionread =
        ref.watch(anamneseQuestionReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          final group = ref.watch(anamneseGroupSelectedProvider);
          if (formValid && group != null) {
            ref.read(anamneseQuestionFormProvider.notifier).submitForm(
                  text: _textTec.text,
                  options: _optionsTec.text,
                );
          }
          if (group == null) {
            showMessageError(context, 'Selecione um grupo');
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: anamneseQuestionread.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(anamneseQuestionFormProvider);
            _textTec.text = formState.model?.text ?? '';
            _optionsTec.text = formState.model?.options.join(',') ?? '';
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
                          label: '* Texto',
                          controller: _textTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: 'Opções',
                          controller: _optionsTec,
                        ),
                        Wrap(
                          children: [
                            TypeMark(
                              type: AnamneseQuestionTypeStatus.simple,
                              optionsChange: () {
                                _optionsTec.text = 'Sim,Não';
                              },
                            ),
                            TypeMark(
                              type: AnamneseQuestionTypeStatus.multiple,
                              optionsChange: () {
                                _optionsTec.text = 'Sim,Não';
                              },
                            ),
                            TypeMark(
                              type: AnamneseQuestionTypeStatus.text,
                              optionsChange: () {
                                _optionsTec.text = '';
                              },
                            ),
                            TypeMark(
                              type: AnamneseQuestionTypeStatus.numeric,
                              optionsChange: () {
                                _optionsTec.text = '';
                              },
                            ),
                          ],
                        ),
                        SwitchListTile(
                          title: const Text('Pergunta ativa ?'),
                          value: ref.watch(anamneseQuestionIsActiveProvider),
                          onChanged: (value) {
                            ref
                                .read(anamneseQuestionIsActiveProvider.notifier)
                                .toggle();
                          },
                        ),
                        SwitchListTile(
                          title: const Text('Pergunta obrigatória ?'),
                          value: ref.watch(anamneseQuestionIsRequiredProvider),
                          onChanged: (value) {
                            ref
                                .read(
                                    anamneseQuestionIsRequiredProvider.notifier)
                                .toggle();
                          },
                        ),
                        const Text('Selecione um grupo *'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                AnamneseGroupModel? result =
                                    await Navigator.of(context)
                                        .push<AnamneseGroupModel>(
                                            MaterialPageRoute(
                                  builder: (context) {
                                    return const AnamneseGroupSelectPage();
                                  },
                                ));

                                if (result != null) {
                                  log('$result');
                                  ref
                                      .read(anamneseGroupSelectedProvider
                                          .notifier)
                                      .set(result);
                                }
                              },
                              icon: const Icon(Icons.search),
                            ),
                            if (ref.watch(anamneseGroupSelectedProvider) !=
                                null)
                              Flexible(
                                child: Text(
                                  '${ref.watch(anamneseGroupSelectedProvider)?.name}',
                                  softWrap: true,
                                ),
                              ),
                            if (ref.watch(anamneseGroupSelectedProvider) !=
                                null)
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(anamneseGroupSelectedProvider
                                            .notifier)
                                        .set(null);
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref
                                .read(anamneseQuestionFormProvider.notifier)
                                .delete();
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
    );
  }
}
