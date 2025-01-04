import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/base/presentation/icons/icon_asset.dart';
import 'package:skeleton/base/presentation/styles/text_styles.dart';
import 'package:skeleton/order/presentation/widgets/adeenio_appbar.dart';
import 'package:skeleton/order/presentation/widgets/adeenio_scrollable_widget.dart';
import 'package:skeleton/order/presentation/widgets/mainpage/order_clickable_item.dart';
import 'package:skeleton/route/order_route.dart';

class OrderMainPage extends StatelessWidget {
  const OrderMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdeenioAppbar(
          state: AdeenioAppbarState.columnTitle,
        ),
        body: Stack(
          children: [
            AdeenioScrollableWidget(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Menu Utama',
                    style: TextStyles.heading24Bold
                        .copyWith(height: 40 / 24, color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                OrderClickableItem(
                  title: 'Pesan',
                  subtitle: 'Pesan kaos plastisol, DTF, jersey',
                  borderColor: const Color(0xFF727D73),
                  backgroundColor: const Color(0xFFF0F0D7),
                  onTap: () {
                    QR.navigator.push(OrderRoute.customerDataPath);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
