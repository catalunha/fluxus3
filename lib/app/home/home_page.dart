import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/authentication/riverpod/auth_prov.dart';
import '../feature/utils/app_mixin_loader.dart';
import '../feature/utils/app_mixin_messages.dart';
import 'comp/home_popmenu.dart';

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
      body: Container(),
    );
  }
}
