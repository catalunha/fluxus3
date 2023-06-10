import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/models/expertise_model.dart';
import '../../../core/models/office_model.dart';
import '../../../core/models/procedure_model.dart';
import '../../expertise/select/expertise_select_page.dart';
import '../../office/select/office_select_page.dart';
import '../../procedure/select/procedure_select_page.dart';
import '../../utils/app_photo_show.dart';
import '../../utils/app_text_title_value.dart';
import 'access_mark.dart';
import 'controller/providers.dart';

class UserProfileAccessPage extends ConsumerWidget {
  final String userProfileId;
  UserProfileAccessPage({
    Key? key,
    required this.userProfileId,
  }) : super(key: key);
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userProfileAccessProvider(id: userProfileId));
    return Scaffold(
      appBar: AppBar(title: const Text('Atualizar este usuário')),
      body: model.when(
        data: (data) {
          log('tem data');
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    AppTextTitleValue(
                      title: 'UserName: ',
                      value: data.userName,
                    ),
                    AppTextTitleValue(
                      title: 'Nome curto: ',
                      value: data.nickname,
                    ),
                    CheckboxListTile(
                      title: const Text("* Liberar acesso ?"),
                      value: ref.watch(isActiveProvider),
                      onChanged: (value) {
                        ref.watch(isActiveProvider.notifier).state =
                            value ?? false;
                      },
                    ),
                    const Text('Marque as opções de acesso para este usuário.'),
                    const Wrap(
                      children: [
                        AccessMark(access: 'admin'),
                        AccessMark(access: 'sec'),
                        AccessMark(access: 'prof'),
                        AccessMark(access: 'fin'),
                      ],
                    ),
                    const Text('Selecione os cargos'),
                    Row(children: [
                      IconButton(
                          onPressed: () async {
                            List<OfficeModel>? result =
                                await Navigator.of(context)
                                    .push<List<OfficeModel>?>(MaterialPageRoute(
                              builder: (context) {
                                return const OfficeSelectPage(
                                  isSingleValue: false,
                                );
                              },
                            ));

                            if (result != null) {
                              for (var element in result) {
                                ref
                                    .read(officeSelectedProvider.notifier)
                                    .update(element);
                              }
                            }
                          },
                          icon: const Icon(Icons.search)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ref
                            .watch(officeSelectedProvider)
                            .map(
                              (e) => Row(
                                children: [
                                  Text('${e.name}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref
                                          .read(officeSelectedProvider.notifier)
                                          .update(e);
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ]),
                    const SizedBox(width: 15),
                    const Text('Selecione as especialidades'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              List<ExpertiseModel>? result =
                                  await Navigator.of(context)
                                      .push<List<ExpertiseModel>?>(
                                          MaterialPageRoute(
                                builder: (context) {
                                  return const ExpertiseSelectPage(
                                    isSingleValue: false,
                                  );
                                },
                              ));

                              if (result != null) {
                                for (var element in result) {
                                  ref
                                      .read(expertiseSelectedProvider.notifier)
                                      .update(element);
                                }
                              }
                            },
                            icon: const Icon(Icons.search)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ref
                              .watch(expertiseSelectedProvider)
                              .map(
                                (e) => Row(
                                  children: [
                                    Text('${e.name}'),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        ref
                                            .read(expertiseSelectedProvider
                                                .notifier)
                                            .update(e);
                                      },
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    const Text('Selecione os procedimentos'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              List<ProcedureModel>? result =
                                  await Navigator.of(context)
                                      .push<List<ProcedureModel>?>(
                                          MaterialPageRoute(
                                builder: (context) {
                                  return const ProcedureSelectPage(
                                    isSingleValue: false,
                                  );
                                },
                              ));

                              if (result != null) {
                                for (var element in result) {
                                  ref
                                      .read(procedureSelectedProvider.notifier)
                                      .update(element);
                                }
                              }
                            },
                            icon: const Icon(Icons.search)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ref
                              .watch(procedureSelectedProvider)
                              .map(
                                (e) => Row(
                                  children: [
                                    Text('${e.name}'),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        ref
                                            .read(procedureSelectedProvider
                                                .notifier)
                                            .update(e);
                                      },
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
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
