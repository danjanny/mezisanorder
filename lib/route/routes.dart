import 'package:flutter/animation.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/presentation/pages/login_page.dart'
    deferred as login_page;
import '../home/presentation/pages/home_page.dart' deferred as home_page;
import 'deferred_loader.dart';

class AppRoutes {
  static const rootPath = "/";
  static const homePath = "/home-dashboard";

  static final routes = [
    // root as login page
    QRoute(
      path: rootPath,
      builder: () => login_page.LoginPage(),
      middleware: [
        DeferredLoader(login_page.loadLibrary),
      ],
    ),
    QRoute(
      path: homePath,
      builder: () => home_page.HomePage(),
      pageType: const QSlidePage(
        transitionDuration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
      middleware: [
        DeferredLoader(home_page.loadLibrary),
      ],
    ),
  ];
}
