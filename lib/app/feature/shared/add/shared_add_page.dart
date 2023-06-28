import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_import_file.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import '../patient/list/controller/providers.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class SharedAddPage extends ConsumerStatefulWidget {
  final String? id;
  const SharedAddPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<SharedAddPage> createState() => _SharedAddPageState();
}

class _SharedAddPageState extends ConsumerState<SharedAddPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _descriptionTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _descriptionTec.text = '';
  }

  @override
  void dispose() {
    _descriptionTec.dispose();
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
    final sharedPatientSelected = ref.read(sharedPatientSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar informação ao paciente'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref
                .read(sharedFormProvider.notifier)
                .submitForm(description: _descriptionTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: sharedRead.when(
        data: (data) {
          String? url;
          if (data != null) {
            final formState = ref.read(sharedFormProvider);
            _descriptionTec.text = formState.model?.description ?? '';
            url = formState.model?.document;
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
                        Text('Paciente: ${sharedPatientSelected?.name}'),
                        // SwitchListTile(
                        //   title: ref.watch(sharedIsPublicProvider)
                        //       ? const Text('Esta informação é PÚBLICA !')
                        //       : const Text('Esta informação é privada !'),
                        //   value: ref.watch(sharedIsPublicProvider),
                        //   onChanged: (value) {
                        //     ref.read(sharedIsPublicProvider.notifier).toggle();
                        //   },
                        // ),
                        AppTextFormField(
                          label: '* Descrição',
                          controller: _descriptionTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                          maxLines: 10,
                        ),
                        const SizedBox(height: 15),
                        AppImportFile(
                          label: 'Click aqui para buscar um documento.',
                          imageUrl: url,
                          setFilePickerResult: (value) {
                            // log('xFile value: ${value?.path}');
                            ref.read(xFileProvider.notifier).state = value;
                            // final xFile = ref.read(xFileProvider);
                            // log('xFile: ${xFile?.path}');
                          },
                          maxHeightImage: 150,
                          maxWidthImage: 100,
                        ),
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
          log('Erro em SharedAddPage');
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
