import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/route/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: const QRouteInformationParser(),
        routerDelegate: QRouterDelegate(AppRoutes.routes));
  }
}
