import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/routes.dart';
import 'package:go_router/go_router.dart';

import '../../core/authentication/riverpod/auth_prov.dart';
import '../utils/app_mixin_loader.dart';
import '../utils/app_mixin_messages.dart';
import 'home_module.dart';
import 'home_popmenu.dart';

class HomePage extends ConsumerWidget with Loader, Messages {
  HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authChNotProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá ${auth.user?.userProfile?.name ?? auth.user?.email}',
        ),
        actions: const [
          HomePopMenu(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              HomeModule(
                title: 'Usuários abc abc abc abc  abc abc abc',
                icon: Icons.people,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.userProfileList.name);
                    },
                    icon: const Icon(Icons.list),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
