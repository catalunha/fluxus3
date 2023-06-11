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

class RoomSavePage extends ConsumerStatefulWidget {
  final String? id;
  const RoomSavePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RoomSavePage> createState() => _RoomSavePageState();
}

class _RoomSavePageState extends ConsumerState<RoomSavePage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _nameTec.text = "";
  }

  @override
  void dispose() {
    _nameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RoomFormState>(roomFormProvider, (previous, next) async {
      if (next.status == RoomFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == RoomFormStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next.status == RoomFormStatus.loading) {
        showLoader(context);
      }
    });

    final roomRead = ref.watch(roomReadProvider(id: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(roomFormProvider.notifier).submitForm(name: _nameTec.text);
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: roomRead.when(
        data: (data) {
          if (data != null && firstTime) {
            final formState = ref.read(roomFormProvider);
            _nameTec.text = formState.model?.name ?? '';
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
                        SwitchListTile(
                          title: const Text('A sala esta disponível ?'),
                          value: ref.watch(roomIsActiveProvider),
                          onChanged: (value) {
                            ref.read(roomIsActiveProvider.notifier).toggle();
                          },
                        ),
                        const SizedBox(height: 15),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref.read(roomFormProvider.notifier).delete();
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
