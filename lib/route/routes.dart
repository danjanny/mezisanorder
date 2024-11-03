import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/authentication/presentation/pages/login_page.dart'
    deferred as login_page;
import 'package:skeleton/home/presentation/pages/home_page.dart' as home_page;
import 'deferred_loader.dart';

class AppRoutes {
  static const rootPath = "/";
  static const homePath = "/home";

  static final routes = [
    QRoute(
      path: rootPath,
      builder: () => login_page.LoginPage(),
      middleware: [
        DeferredLoader(login_page.loadLibrary),
      ],
    ),
    QRoute(
      path: homePath,
      builder: () => const home_page.HomePage(),
    ),
  ];
}
