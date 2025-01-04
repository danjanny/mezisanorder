import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../base/presentation/icons/icon_asset.dart';
import '../../../../base/presentation/styles/text_styles.dart';
import '../../../../base/presentation/textformfield/app_colors.dart';

class OrderClickableItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Color? borderColor;
  final Color? backgroundColor;

  const OrderClickableItem(
      {super.key,
      this.onTap,
      this.title,
      this.subtitle,
      this.icon,
      this.borderColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 13),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? AppColors.grey2, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? 'Title',
                      style: TextStyles.body16Bold
                          .copyWith(height: 20 / 16, color: Colors.black)),
                  const SizedBox(height: 2),
                  Text(subtitle ?? 'Subtitle',
                      style: TextStyles.body14Regular
                          .copyWith(height: 20 / 14, color: AppColors.grey)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Add some spacing between text and image
            icon ?? SvgPicture.asset(IconAsset.mezisanOrderMainIcon),
            // Replace with your SVG asset path
          ],
        ),
      ),
    );
  }
}
