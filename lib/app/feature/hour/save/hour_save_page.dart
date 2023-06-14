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

class HourSavePage extends ConsumerStatefulWidget {
  final String? id;
  const HourSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<HourSavePage> createState() => _HourSavePageState();
}

class _HourSavePageState extends ConsumerState<HourSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _startTec = TextEditingController();
  final _endTec = TextEditingController();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _nameTec.text = "";
    _startTec.text = "";
    _endTec.text = "";
  }

  @override
  void dispose() {
    _nameTec.dispose();
    _startTec.dispose();
    _endTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HourFormState>(hourFormProvider, (previous, next) async {
      if (next.status == HourFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == HourFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == HourFormStatus.loading) {
        showLoader(context);
      }
    });

    final hourRead = ref.watch(hourReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(hourFormProvider.notifier).submitForm(name: _nameTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: hourRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(hourFormProvider);
            _nameTec.text = formState.model?.name ?? '';
            _startTec.text = formState.model?.start ?? '';
            _endTec.text = formState.model?.end ?? '';
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
                          label: '* Start',
                          controller: _startTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* End',
                          controller: _endTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        SwitchListTile(
                          title: const Text('O horario esta disponível ?'),
                          value: ref.watch(hourIsActiveProvider),
                          onChanged: (value) {
                            ref.read(hourIsActiveProvider.notifier).toggle();
                          },
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(hourFormProvider.notifier).delete();
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
