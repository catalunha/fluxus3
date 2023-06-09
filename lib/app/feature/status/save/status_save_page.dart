import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_delete.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class StatusSavePage extends ConsumerStatefulWidget {
  final String? id;
  const StatusSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<StatusSavePage> createState() => _StatusSavePageState();
}

class _StatusSavePageState extends ConsumerState<StatusSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _nameTec.text = '';
    _descriptionTec.text = '';
  }

  @override
  void dispose() {
    _nameTec.dispose();
    _descriptionTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<StatusFormState>(statusFormProvider, (previous, next) async {
      if (next.status == StatusFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == StatusFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == StatusFormStatus.loading) {
        showLoader(context);
      }
    });

    final statusRead = ref.watch(statusReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(statusFormProvider.notifier).submitForm(
                  name: _nameTec.text,
                  description: _descriptionTec.text,
                );
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: statusRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(statusFormProvider);
            _nameTec.text = formState.model?.name ?? '';
            _descriptionTec.text = formState.model?.description ?? '';
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
                          label: '* Nome',
                          controller: _nameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Descrição',
                          controller: _descriptionTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(statusFormProvider.notifier).delete();
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
          log('Erro em Lista de status');
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
