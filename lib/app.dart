import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'base/presentation/styles/text_form_field_style.dart';
import 'base/presentation/styles/text_styles.dart';
import 'route/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var box = Hive.box('settings');

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
                routerDelegate: QRouterDelegate(
                    AppRoutes.routes,
                    initPath: box.get('isLogin', defaultValue: false)
                        ? AppRoutes.homePath : AppRoutes.rootPath,
                    observers: [ChuckerFlutter.navigatorObserver])),
          ),
        );
      },
    );
  }
}
