import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/providers.dart';
import 'package:intl/intl.dart';

import '../../utils/app_photo_show.dart';
import '../../utils/app_text_title_value.dart';

class UserProfileViewPage extends ConsumerWidget {
  final String userProfileId;
  UserProfileViewPage({
    Key? key,
    required this.userProfileId,
  }) : super(key: key);
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userProfileViewProvider(id: userProfileId));
    return Scaffold(
      appBar: AppBar(title: const Text('Dados deste usuário')),
      body: model.when(
        data: (data) {
          log('tem data');
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppTextTitleValue(
                      title: 'Foto:',
                      value: '',
                    ),
                    AppImageShow(
                      photoUrl: data.photo,
                      height: 100,
                      width: 100,
                    ),
                    // AppTextTitleValue(
                    //   title: 'id: ',
                    //   value: data.id,
                    // ),
                    AppTextTitleValue(
                      title: 'UserName: ',
                      value: data.userName,
                    ),
                    AppTextTitleValue(
                      title: 'E-mail: ',
                      value: data.email,
                    ),
                    AppTextTitleValue(
                      title: 'Nome curto: ',
                      value: data.nickname,
                    ),
                    AppTextTitleValue(
                      title: 'Nome completo: ',
                      value: data.name,
                    ),
                    AppTextTitleValue(
                      title: 'CPF: ',
                      value: data.cpf,
                    ),
                    AppTextTitleValue(
                      title: 'Registro: ',
                      value: data.register,
                    ),
                    AppTextTitleValue(
                      title: 'Telefone: ',
                      value: data.phone,
                    ),
                    AppTextTitleValue(
                      title: 'Endereço: ',
                      value: data.address,
                    ),
                    AppTextTitleValue(
                      title: 'Região: ',
                      value:
                          '${data.region?.uf}. ${data.region?.city}. ${data.region?.name}',
                    ),
                    AppTextTitleValue(
                      title: 'Sexo: ',
                      value: data.isFemale ?? true ? 'Feminino' : 'Masculino',
                    ),
                    AppTextTitleValue(
                      title: 'Acesso: ',
                      value: data.isActive ? 'LIBERADO' : 'bloqueado',
                    ),
                    AppTextTitleValue(
                      title: 'Aniversário: ',
                      value: data.birthday == null
                          ? '...'
                          : dateFormat.format(data.birthday!),
                    ),
                    AppTextTitleValue(
                      title: 'Acessa como: ',
                      value: data.access.join('\n'),
                    ),
                    AppTextTitleValue(
                      title: 'Cargos: ',
                      value:
                          data.offices?.map((e) => e.name).toList().join(', '),
                    ),
                    AppTextTitleValue(
                      title: 'Offices: ',
                      value: data.offices?.map((e) => e.id).toList().join(', '),
                    ),
                    AppTextTitleValue(
                      title: 'Especialidades: ',
                      value: data.expertises
                          ?.map((e) => e.name)
                          .toList()
                          .join(', '),
                    ),
                    AppTextTitleValue(
                      title: 'Procedimentos: ',
                      value: data.procedures
                          ?.map((e) => e.code)
                          .toList()
                          .join(', '),
                    ),
                  ],
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
