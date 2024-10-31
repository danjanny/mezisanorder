import 'package:flutter/material.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_styles.dart';

import '../textformfield/app_colors.dart';

enum ToastStatus { danger, success, warning }

enum ToastPosition { top, bottom }

class QuickcountToast extends StatelessWidget {
  final String message;
  final ToastStatus status;
  final double width;

  const QuickcountToast({
    super.key,
    required this.message,
    required this.status,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    switch (status) {
      case ToastStatus.danger:
        // backgroundColor = const Color(0xFF741B1A);
        backgroundColor = AppColors.brandTelkomsel;
        break;
      case ToastStatus.success:
        backgroundColor = const Color(0xFF0F893C);
        break;
      case ToastStatus.warning:
        backgroundColor = Colors.orange;
        break;
    }

    return Container(
      width: width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: QuickCountTextStyles.body12Regular
                  .copyWith(height: 18 / 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  static void showToast(
    BuildContext context,
    String message,
    ToastStatus status,
    double width, {
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // top: position == ToastPosition.top ? 16 : null,
        top: position == ToastPosition.top ? 85 : null,
        bottom: position == ToastPosition.bottom ? 80 : null,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: QuickcountToast(
            message: message,
            status: status,
            width: width,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static void show(
    BuildContext context,
    BoxConstraints constraints,
    String message,
    ToastStatus status,
  ) {
    double viewportHeight = constraints.maxHeight;
    double width = constraints.maxWidth > 1024 ? 430 : constraints.maxWidth;
    ToastPosition position =
        viewportHeight >= 840 ? ToastPosition.bottom : ToastPosition.top;

    showToast(
      context,
      message,
      status,
      width,
      position:
          ToastPosition.top, // default toast shown in the bottom of viewport
    );
  }
}
