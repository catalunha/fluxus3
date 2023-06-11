import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';
import 'package:go_router/go_router.dart';

import '../../../core/authentication/riverpod/auth_prov.dart';
import '../../../core/models/region_model.dart';
import '../../region/select/region_select_page.dart';
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
  DateTime? _birthday = DateTime.now();
  final dateFormat = DateFormat('dd/MM/y');
  @override
  void initState() {
    final user = ref.read(authChNotProvider).user;
    super.initState();
    _nameTec.text = user?.userProfile?.name ?? "";
    _nicknameTec.text = user?.userProfile?.nickname ?? "";
    _phoneTec.text = user?.userProfile?.phone ?? "";
    _cpfTec.text = user?.userProfile?.cpf ?? "";
    _addressTec.text = user?.userProfile?.address ?? "";
    _registerTec.text = user?.userProfile?.register ?? "";
    isFemale = user?.userProfile?.isFemale ?? true;
    _birthday = user?.userProfile?.birthday;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //print("WidgetsBinding1");
      ref.read(regionSelectedProvider.notifier).state =
          user?.userProfile?.region;
    });
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            RegionModel? result = await Navigator.of(context)
                                .push<RegionModel>(MaterialPageRoute(
                              builder: (context) {
                                return const RegionSelectPage();
                              },
                            ));

                            if (result != null) {
                              log('$result');
                              ref.read(regionSelectedProvider.notifier).state =
                                  result;
                              // contextTemp
                              //     .add(UserProfileSaveEventAddRegion(result));
                            } else {
                              ref.read(regionSelectedProvider.notifier).state =
                                  null;
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                        if (ref.watch(regionSelectedProvider) != null)
                          Flexible(
                            child: Text(
                              '${ref.watch(regionSelectedProvider)?.uf}-${ref.watch(regionSelectedProvider)?.city}-${ref.watch(regionSelectedProvider)?.name}',
                              softWrap: true,
                            ),
                          ),
                        if (ref.watch(regionSelectedProvider) != null)
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(regionSelectedProvider.notifier)
                                    .state = null;
                              },
                              icon: const Icon(Icons.delete))
                      ],
                    ),
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
                    // SizedBox(
                    //   width: 300,
                    //   height: 100,
                    //   child: CupertinoDatePicker(
                    //     initialDateTime: _birthday,
                    //     mode: CupertinoDatePickerMode.date,
                    //     onDateTimeChanged: (DateTime newDate) {
                    //       _birthday = newDate;
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Aniversário:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              if (newDate == null) {
                                setState(() {
                                  _birthday = null;
                                });
                              } else {
                                setState(() {
                                  _birthday = newDate;
                                });
                              }
                            },
                            child: const Icon(Icons.date_range),
                          ),
                          const SizedBox(width: 10),
                          Text(_birthday != null
                              ? dateFormat.format(_birthday!)
                              : "Não informado"),
                        ],
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
