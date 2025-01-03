import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/order/presentation/pages/order_confirm_page.dart'
    deferred as order_confirm_page;
import 'package:skeleton/order/presentation/pages/order_customer_data_page.dart'
    deferred as order_customer_data_page;
import 'package:skeleton/order/presentation/pages/order_description_page.dart'
    deferred as order_description_page;
import 'package:skeleton/order/presentation/pages/order_image_upload_page.dart'
    deferred as order_image_upload_page;
import 'package:skeleton/order/presentation/pages/order_main_page.dart'
    deferred as order_main_page;

import 'deferred_loader.dart';

class OrderRoute {
  static const mainPath = "/main";
  static const customerDataPath = "/customer-data";
  static const orderDescriptionPath = "/order-description";
  static const imageUploadPath = "/image-upload";
  static const confirmPath = "/confirm";

  static final routes = [
    QRoute(
        path: mainPath,
        builder: () => order_main_page.OrderMainPage(),
        middleware: [
          DeferredLoader(order_main_page.loadLibrary),
        ]),
    QRoute(
        path: customerDataPath,
        builder: () => order_customer_data_page.OrderCustomerDataPage(),
        middleware: [
          DeferredLoader(order_customer_data_page.loadLibrary),
        ]),
    QRoute(
        path: orderDescriptionPath,
        builder: () => order_description_page.OrderDescriptionPage(),
        middleware: [
          DeferredLoader(order_description_page.loadLibrary),
        ]),
    QRoute(
        path: imageUploadPath,
        builder: () => order_image_upload_page.OrderImageUploadPage(),
        middleware: [
          DeferredLoader(order_image_upload_page.loadLibrary),
        ]),
    QRoute(
        path: confirmPath,
        builder: () => order_confirm_page.OrderConfirmPage(),
        middleware: [
          DeferredLoader(order_confirm_page.loadLibrary),
        ]),
  ];
}
