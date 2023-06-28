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

class RegionSavePage extends ConsumerStatefulWidget {
  final String? id;
  const RegionSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RegionSavePage> createState() => RregionSavePageState();
}

class RregionSavePageState extends ConsumerState<RegionSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _ufTec = TextEditingController();
  final _cityTec = TextEditingController();
  final _nameTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _ufTec.text = '';
    _cityTec.text = '';
    _nameTec.text = '';
  }

  @override
  void dispose() {
    _ufTec.dispose();
    _cityTec.dispose();
    _nameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RegionFormState>(regionFormProvider, (previous, next) async {
      if (next.status == RegionFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == RegionFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == RegionFormStatus.loading) {
        showLoader(context);
      }
    });

    final regionRead = ref.watch(regionReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(regionFormProvider.notifier).submitForm(
                  uf: _ufTec.text,
                  city: _cityTec.text,
                  name: _nameTec.text,
                );
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: regionRead.when(
        data: (data) {
          if (data != null) {
            final formState = ref.read(regionFormProvider);
            _ufTec.text = formState.model?.uf ?? '';
            _cityTec.text = formState.model?.city ?? '';
            _nameTec.text = formState.model?.name ?? '';
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
                          label: '* Estado',
                          controller: _ufTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Cidade',
                          controller: _cityTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: '* Componentes',
                          controller: _nameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(regionFormProvider.notifier).delete();
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
          log('Erro em Lista de regiao');
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
