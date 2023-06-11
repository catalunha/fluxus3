import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../utils/app_button.dart';
import '../../../utils/app_mixin_loader.dart';
import '../../../utils/app_mixin_messages.dart';
import '../../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class UserRegisterEmailPage extends ConsumerStatefulWidget {
  const UserRegisterEmailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserRegisterEmailPage> createState() =>
      _UserRegisterEmailPageState();
}

class _UserRegisterEmailPageState extends ConsumerState<UserRegisterEmailPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _emailTEC = TextEditingController();
  final _passwordTEC = TextEditingController();

  @override
  void dispose() {
    _emailTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserRegisterEmailFormState>(userRegisterEmailFormProvider,
        (prev, next) async {
      if (next.status == UserRegisterEmailFormStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == UserRegisterEmailFormStatus.loading) {
        showLoader(context);
      }
      if (next.status == UserRegisterEmailFormStatus.success) {
        hideLoader(context);
        var contextTemp = Navigator.of(context);
        await alertEmailVerified(context);
        contextTemp.pop();
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
                            'Cadastro',
                          ),
                          const Text(
                              'Preencha os campos abaixo para criar o seu cadastro.'),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            label: 'E-mail',
                            controller: _emailTEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('email obrigatório.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            label: 'Senha',
                            obscureText: true,
                            controller: _passwordTEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória.'),
                              Validatorless.min(6, 'Minimo de 6 caracteres.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            label: 'Confirme senha',
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'Confirmação de senha obrigatória.'),
                                Validatorless.min(6, 'Minimo de 6 caracteres.'),
                                Validatorless.compare(_passwordTEC,
                                    'Senha diferente do informado anteriormente.')
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                              'Após clicar em CADASTRAR você receberá um email para validação deste cadastro. É necessário ir na caixa de entrada do email informado aqui e validar seu cadastro antes de tentar login.'),
                          const SizedBox(
                            height: 20,
                          ),
                          AppButton(
                            label: 'Cadastrar',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                ref
                                    .read(
                                        userRegisterEmailFormProvider.notifier)
                                    .submit(
                                      email: _emailTEC.text,
                                      password: _passwordTEC.text,
                                    );
                              }
                            },
                            // width: context.width,
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

  Future<bool?> alertEmailVerified(BuildContext context) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Lembre-se de olhar seu email.'),
                  const Text('Para validar seu cadastro.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Entendi'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
