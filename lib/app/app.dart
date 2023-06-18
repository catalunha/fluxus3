import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/authentication/riverpod/auth_prov.dart';
import 'routes.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouterProvIW = ref.watch(goRouterProv);
    ref.watch(authCheckFutProvider);
    return MaterialApp.router(
      routeInformationParser: goRouterProvIW.routeInformationParser,
      routeInformationProvider: goRouterProvIW.routeInformationProvider,
      routerDelegate: goRouterProvIW.routerDelegate,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Fluxus 3.0',
      theme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}



/*

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}

*/