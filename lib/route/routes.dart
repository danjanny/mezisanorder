import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/route/root_middleware.dart';
import '../authentication/presentation/pages/login_page.dart'
    deferred as login_page;
import '../home/presentation/pages/home_page.dart' deferred as home_page;
import 'deferred_loader.dart';

class AppRoutes {
  static const rootPath = "/";
  static const homePath = "/home-dashboard";

  static final routes = [
    QRoute(
      path: rootPath,
      builder: () =>
          login_page.MyHomePage(title: 'Skeleton Code Clean Flutter'),
      middleware: [
        DeferredLoader(login_page.loadLibrary),
        RootMiddleware(),
      ],
    ),
    QRoute(
      path: homePath,
      builder: () => home_page.HomePage(),
      middleware: [
        DeferredLoader(home_page.loadLibrary),
      ],
    ),
  ];
}
