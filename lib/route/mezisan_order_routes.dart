import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/order/presentation/pages/order_main_page.dart'
    deferred as order_main_page;
import 'package:skeleton/order/presentation/pages/order_splash_screen_page.dart'
    deferred as order_splash_screen_page;
import 'package:skeleton/route/order_route.dart';
import 'deferred_loader.dart';

class MezisanOrderRoutes {
  static const rootPath = "/";
  static const mainPagePath = "/main";
  static final routes = [
    QRoute(
        path: rootPath,
        builder: () => order_splash_screen_page.OrderSplashScreenPage(),
        middleware: [
          DeferredLoader(order_splash_screen_page.loadLibrary),
        ]),
    QRoute(
        path: mainPagePath,
        builder: () => order_main_page.OrderMainPage(),
        middleware: [
          DeferredLoader(order_main_page.loadLibrary),
        ]),
    ...OrderRoute.routes
  ];
}
