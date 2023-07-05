import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../utils/app_text_title_value.dart';
import 'controller/providers.dart';

class PatientViewPage extends ConsumerWidget {
  final String id;

  PatientViewPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientRead = ref.watch(patientReadProvider(id: id));

    return Scaffold(
      appBar: AppBar(title: const Text('Dados do paciente')),
      body: patientRead.when(
        data: (data) {
          if (data == null) {
            return const Center(
              child: Text('Não encontrei Paciente com este ID'),
            );
          } else {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        title: 'Aniversário: ',
                        value: data.birthday == null
                            ? '...'
                            : dateFormat.format(data.birthday!),
                      ),
                      AppTextTitleValue(
                        title: 'Familiares.name: ',
                        value:
                            data.family?.map((e) => e.name).toList().join(', '),
                      ),
                      AppTextTitleValue(
                        title: 'Familiares.nickname: ',
                        value: data.family
                            ?.map((e) => e.nickname)
                            .toList()
                            .join(', '),
                      ),
                      AppTextTitleValue(
                        title: 'Plano de Saúde: ',
                        value: data.healthPlans
                            ?.map((e) => e.code)
                            .toList()
                            .join(', '),
                      ),
                      AppTextTitleValue(
                        title: 'Plano de Saúde id: ',
                        value: data.healthPlans
                            ?.map((e) => e.id)
                            .toList()
                            .join(', '),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        error: (error, stackTrace) {
          log('error');
          log('stackTrace');
          return const Center(
            child: Text('Paciente não encontrado'),
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
