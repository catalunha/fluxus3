import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fluxus3/app/feature/user_profile/list/controller/providers.dart';

import 'user_profile_obj.dart';

class UserProfileListPage extends ConsumerWidget {
  const UserProfileListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(userProfileListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
      ),
      body: list.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final level = data[index];
            return UserProfileObj(
              model: level,
            );
          },
        );
      }, error: (error, stackTrace) {
        log('Erro em Lista de usuarios');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de usuarios'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
