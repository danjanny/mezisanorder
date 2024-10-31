import 'package:flutter/material.dart';
import 'package:skeleton/base/presentation/button/quickcount_custom_button.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_styles.dart';

import '../textformfield/app_colors.dart';

class QuickcountBottomSheet extends StatelessWidget {
  final Widget Function(BuildContext) contentBuilder;

  const QuickcountBottomSheet({
    super.key,
    required this.contentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.0,
            height: 6.0,
            decoration: const BoxDecoration(
              color: Color(0xFFE9E8ED),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          contentBuilder(context),
        ],
      ),
    );
  }
}

void showTsmartpayCustomBottomSheet({
  required BuildContext context,
  Widget? image,
  String? title,
  String? subtitle,
  String? textButton,
  VoidCallback? onTapButton,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return QuickcountBottomSheet(
        contentBuilder: (context) => Container(
          // color: AppColors.mrsSuperLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image ?? Container(),
              const SizedBox(
                height: 24,
              ),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: QuickCountTextStyles.body16Bold.copyWith(
                  color: const Color(0xFF181C21),
                  height: 24 / 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle ?? '',
                textAlign: TextAlign.center,
                style: QuickCountTextStyles.body12Regular.copyWith(
                  color: AppColors.textSecondary,
                  height: 18 / 12,
                ),
              ),
              const SizedBox(height: 40.0),
              QuickcountButton(
                state: QuickcountButtonState.enabled,
                text: textButton ?? '',
                onPressed: onTapButton,
              ),
            ],
          ),
        ),
      );
    },
  );
}
