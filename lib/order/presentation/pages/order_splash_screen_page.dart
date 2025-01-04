import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/base/presentation/icons/icon_asset.dart';
import 'package:skeleton/route/mezisan_order_routes.dart';

class OrderSplashScreenPage extends StatefulWidget {
  const OrderSplashScreenPage({super.key});

  @override
  State<OrderSplashScreenPage> createState() => _OrderSplashScreenPageState();
}

class _OrderSplashScreenPageState extends State<OrderSplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      QR.navigator.replace(MezisanOrderRoutes.rootPath, MezisanOrderRoutes.mainPagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          IconAsset.mezisanSplashScreenIcon,
          width: 200,
        ),
      ),
    );
  }
}
