import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/authentication/riverpod/auth_prov.dart';
import '../../../routes.dart';

class HomePopMenu extends ConsumerWidget {
  const HomePopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authChNotProvider);
    return PopupMenuButton(
      offset: Offset.fromDirection(120.0, 70.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Editar perfil'),
              onPressed: () {
                Navigator.pop(context);
                context.goNamed(AppPage.userProfileEdit.name);
              },
              icon: const Icon(Icons.person_outline_outlined),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Sair'),
              onPressed: () {
                Navigator.pop(context);
                // TODO
                // Como resolver isto profissionalmente.
                ref.read(logoutProvider);
                ref.read(authChNotProvider.notifier).logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ];
      },
      child: Tooltip(
        message: 'Click para ver opções',
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: UserPhoto(url: auth.user?.userProfile?.photo)),
      ),
    );
  }
}

class UserPhoto extends StatelessWidget {
  final String? url;
  const UserPhoto({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return url != null
        ? Image.network(
            url!,
            height: 40,
            width: 40,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.person,
                // color: Colors.black,
              );
            },
          )
        : const Align(
            alignment: Alignment.center,
            child: Text(
              ':-) ',
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
