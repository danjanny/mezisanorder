import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'route/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          alignment: Alignment.topCenter,
          child: Container(
            width: constraints.maxWidth > 1024 ? 430 : constraints.maxWidth,
            child: MaterialApp.router(
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
                  bodyLarge: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(),
                ),
                buttonTheme: const ButtonThemeData(
                  buttonColor: Colors.blue,
                  textTheme: ButtonTextTheme.primary,
                ),
                // Add other custom component themes here
              ),
              routeInformationParser: const QRouteInformationParser(),
              routerDelegate: QRouterDelegate(AppRoutes.routes),
            ),
          ),
        );
      },
    );
  }
}
