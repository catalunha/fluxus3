import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../../routes.dart';
import '../../utils/app_button.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class UserLoginPage extends ConsumerStatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends ConsumerState<UserLoginPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _emailTEC = TextEditingController();
  final _passwordTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailTEC.dispose();
    _passwordTEC.dispose();
    hideLoader(context);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserLoginStatus>(userLoginStatusProvider, (prev, next) {
      if (next == UserLoginStatus.error) {
        hideLoader(context);
        final error = ref.read(userLoginErrorProvider);
        showMessageError(context, error);
      }
      if (next == UserLoginStatus.success) {
        hideLoader(context);
      }
      if (next == UserLoginStatus.loading) {
        showLoader(context);
      }
    });
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constrainsts) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constrainsts.maxHeight,
                  maxWidth: 400,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Informações para acesso ao',
                          ),
                          const Text(
                            'Fluxus 3',
                            style: TextStyle(fontSize: 50),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            label: 'Informe o e-mail cadastrado',
                            controller: _emailTEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('email obrigatório.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFormField(
                            label: 'Informe a senha cadastrada',
                            controller: _passwordTEC,
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Senha obrigatória.'),
                                Validatorless.min(6, 'Minimo de 6 caracteres.'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppButton(
                            label: 'Solicitar acesso',
                            onPressed: () async {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                ref
                                    .read(userLoginEmailFormProvider.notifier)
                                    .submit(
                                      email: _emailTEC.text,
                                      password: _passwordTEC.text,
                                    );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Esqueceu sua senha ?'),
                              TextButton(
                                onPressed: () {
                                  if (_emailTEC.text.isNotEmpty) {
                                    ref
                                        .read(
                                            userLoginEmailFormProvider.notifier)
                                        .resetPassword(
                                          email: _emailTEC.text,
                                        );
                                    showMessageInfo(context,
                                        'Enviamos instruções para seu email.');
                                  } else {
                                    showMessageError(
                                        context, 'Informe o email cadastrado');
                                  }
                                },
                                child: const Text(
                                  'Criar uma nova.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não possui uma conta ?'),
                              TextButton(
                                onPressed: () {
                                  context.goNamed(AppPage.registerEmail.name);
                                },
                                child: const Text(
                                  'CADASTRE-SE.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
