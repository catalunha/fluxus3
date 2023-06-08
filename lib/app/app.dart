import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/authentication/riverpod/auth_prov.dart';
import 'routes.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goRouterProvIW = ref.watch(goRouterProv);
    ref.watch(authCheckFutProvider);
    return MaterialApp.router(
      routeInformationParser: goRouterProvIW.routeInformationParser,
      routeInformationProvider: goRouterProvIW.routeInformationProvider,
      routerDelegate: goRouterProvIW.routerDelegate,
      title: 'RepeatAndLearn',
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
