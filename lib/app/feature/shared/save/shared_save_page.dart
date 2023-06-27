import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class SharedSavePage extends ConsumerStatefulWidget {
  final String? id;
  const SharedSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<SharedSavePage> createState() => _SharedSavePageState();
}

class _SharedSavePageState extends ConsumerState<SharedSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _historyTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _historyTec.text = "";
  }

  @override
  void dispose() {
    _historyTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SharedFormState>(sharedFormProvider, (previous, next) async {
      if (next.status == SharedFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == SharedFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == SharedFormStatus.loading) {
        showLoader(context);
      }
    });

    final sharedRead = ref.watch(sharedReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref
                .read(sharedFormProvider.notifier)
                .submitForm(history: _historyTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: sharedRead.when(
        data: (data) {
          if (data != null) {
            final formState = ref.read(sharedFormProvider);
            _historyTec.text = formState.model?.history ?? '';
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
                          label: '* Descrição',
                          controller: _historyTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        const SizedBox(height: 15),
                        // AppDelete(
                        //   isVisible: data != null,
                        //   action: () {
                        //     ref.read(sharedFormProvider.notifier).delete();
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
          log('Erro em SharedSavePage');
          log('$error');
          log('$stackTrace');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
