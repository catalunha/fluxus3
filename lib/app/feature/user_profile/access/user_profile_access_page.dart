import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
