import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'base/presentation/styles/text_form_field_style.dart';
import 'base/presentation/styles/text_styles.dart';
import 'route/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: constraints.maxWidth > 1024 ? 430 : constraints.maxWidth,
            child: MaterialApp.router(
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  bodyMedium: TextStyles.body12Medium,
                  bodyLarge: TextStyles.body12Regular,
                ),
                inputDecorationTheme:
                    TextFormFieldStyle.getDefaultInputDecorationTheme(),
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
