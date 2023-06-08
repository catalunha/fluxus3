import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';
import 'package:go_router/go_router.dart';

import '../../../core/authentication/riverpod/auth_prov.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'providers/providers.dart';
import 'providers/states.dart';

class UserProfileEditPage extends ConsumerStatefulWidget {
  const UserProfileEditPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UserProfileEditPage> createState() =>
      _UserProfileEditPageState();
}

class _UserProfileEditPageState extends ConsumerState<UserProfileEditPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    final user = ref.read(authChNotProvider).user;
    _nameTec.text = user?.userProfile?.name ?? "";
  }

  @override
  void dispose() {
    _nameTec.dispose();
    hideLoader(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserProfileEditStatus>(userProfileEditStatusProvider,
        (previous, next) async {
      if (next == UserProfileEditStatus.error) {
        hideLoader(context);
        final error = ref.read(userProfileEditErrorProvider);
        showMessageError(context, error);
      }
      if (next == UserProfileEditStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next == UserProfileEditStatus.loading) {
        showLoader(context);
      }
    });

    final user = ref.read(authChNotProvider).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref
                .read(userProfileEditProvider.notifier)
                .userProfileEditSubmitForm(name: _nameTec.text);
          }
        },
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'email: ${user?.userProfile?.email ?? "Oops. Isto é um erro."}',
                    ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: '* Seu nome',
                      controller: _nameTec,
                      validator:
                          Validatorless.required('Nome completo é obrigatório'),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
