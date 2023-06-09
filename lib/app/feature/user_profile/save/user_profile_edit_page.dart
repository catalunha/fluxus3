import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';
import 'package:go_router/go_router.dart';

import '../../../core/authentication/riverpod/auth_prov.dart';
import '../../utils/app_import_image.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

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
  final _nicknameTec = TextEditingController();
  final _nameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _cpfTec = TextEditingController();
  final _addressTec = TextEditingController();
  final _registerTec = TextEditingController();
  bool isFemale = true;
  DateTime _birthday = DateTime.now();
  @override
  void initState() {
    super.initState();
    final user = ref.read(authChNotProvider).user;
    _nameTec.text = user?.userProfile?.name ?? "";
    _nicknameTec.text = user?.userProfile?.nickname ?? "";
    _phoneTec.text = user?.userProfile?.phone ?? "";
    _cpfTec.text = user?.userProfile?.cpf ?? "";
    _addressTec.text = user?.userProfile?.address ?? "";
    _registerTec.text = user?.userProfile?.register ?? "";
    isFemale = user?.userProfile?.isFemale ?? true;
    _birthday = user?.userProfile?.birthday ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameTec.dispose();
    hideLoader(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserProfileSaveStatus>(userProfileSaveStatusProvider,
        (previous, next) async {
      if (next == UserProfileSaveStatus.error) {
        hideLoader(context);
        final error = ref.read(userProfileSaveErrorProvider);
        showMessageError(context, error);
      }
      if (next == UserProfileSaveStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        context.pop(); //sai da pagina
      }
      if (next == UserProfileSaveStatus.loading) {
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
            ref.read(userProfileSaveProvider.notifier).submitForm(
                  name: _nameTec.text,
                  nickname: _nicknameTec.text,
                  cpf: _cpfTec.text,
                  phone: _phoneTec.text,
                  address: _addressTec.text,
                  register: _registerTec.text,
                  isFemale: isFemale,
                  birthday: _birthday,
                );
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
                      'Id: ${user?.userProfile!.id}',
                    ),
                    Text(
                      'email: ${user?.userProfile!.email}',
                    ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: '* Seu nome curto ou apelido',
                      controller: _nicknameTec,
                      validator:
                          Validatorless.required('Nome curto é obrigatório'),
                    ),
                    AppTextFormField(
                      label: '* Seu nome',
                      controller: _nameTec,
                      validator:
                          Validatorless.required('Nome completo é obrigatório'),
                    ),
                    AppTextFormField(
                      label: '* Seu CPF. Apenas números',
                      controller: _cpfTec,
                      validator: Validatorless.multiple([
                        Validatorless.required('CPF é obrigatório'),
                        Validatorless.cpf('Número de CPF é inválido')
                      ]),
                    ),
                    AppTextFormField(
                        label: '* Seu telefone. Formato: DDDNÚMERO',
                        controller: _phoneTec,
                        validator: Validatorless.multiple([
                          Validatorless.number(
                              'Apenas números. Formato: DDDNÚMERO'),
                          Validatorless.required('Telefone é obrigatório'),
                        ])),
                    AppTextFormField(
                      label: 'Seu endereço completo. (Rua X, ..., CEP ..., )',
                      controller: _addressTec,
                    ),

                    AppTextFormField(
                      label: 'Seu registro no seu conselho',
                      controller: _registerTec,
                    ),
                    CheckboxListTile(
                      title: const Text("Sexo feminino ?"),
                      onChanged: (value) {
                        setState(() {
                          isFemale = value ?? true;
                        });
                      },
                      value: isFemale,
                    ),
                    const Text('Selecione a região *'),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //         onPressed: () async {
                    //           var contextTemp =
                    //               context.read<UserProfileSaveBloc>();
                    //           RegionModel? result = await Navigator.of(context)
                    //               .pushNamed('/region/select') as RegionModel?;
                    //           if (result != null) {
                    //             contextTemp
                    //                 .add(UserProfileSaveEventAddRegion(result));
                    //           }
                    //         },
                    //         icon: const Icon(Icons.search)),
                    //     BlocBuilder<UserProfileSaveBloc, UserProfileSaveState>(
                    //       builder: (context, state) {
                    //         return Text(
                    //             '${state.region?.uf}. ${state.region?.city}. ${state.region?.name}');
                    //       },
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 5),
                    AppImportImage(
                      label:
                          'Click aqui para buscar sua foto, apenas face. Padrão 3x4.',
                      imageUrl: user?.userProfile!.photo,
                      setXFile: (value) =>
                          ref.read(xFileProvider.notifier).state = value,
                      maxHeightImage: 150,
                      maxWidthImage: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text('Aniversário'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: CupertinoDatePicker(
                        initialDateTime: _birthday,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          _birthday = newDate;
                        },
                      ),
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
