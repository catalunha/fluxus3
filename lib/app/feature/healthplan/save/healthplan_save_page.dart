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
  @override
  void initState() {
    super.initState();
    _codeTec.text = "";
  }

  @override
  void dispose() {
    _codeTec.dispose();
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
        print(next.model); //sai do Dialog do loading
        context.pop(next.model); //sai da pagina
      }
      if (next.status == HealthPlanFormStatus.loading) {
        showLoader(context);
      }
    });

    final healthPlanRead = ref.watch(healthPlanReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref
                .read(healthPlanFormProvider.notifier)
                .submitForm(code: _codeTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: healthPlanRead.when(
        data: (data) {
          if (data != null) {
            final formState = ref.read(healthPlanFormProvider);
            _codeTec.text = formState.model?.code ?? '';
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
                        AppTextFormField(
                          label: '* Informe o código do plano',
                          controller: _codeTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(healthPlanFormProvider.notifier).delete();
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
