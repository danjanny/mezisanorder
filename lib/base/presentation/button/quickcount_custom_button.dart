import 'package:flutter/material.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_styles.dart';

import '../textformfield/app_colors.dart';

enum QuickcountButtonState { enabled, disabled, outlined }

class QuickcountButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? enabledBackgroundColor;
  final QuickcountButtonState? state;
  final VoidCallback? onPressed;

  const QuickcountButton(
      {super.key,
      this.text = 'Text Button',
      this.textColor = Colors.white,
      this.enabledBackgroundColor = AppColors.backgroundSolidsRed,
      this.state = QuickcountButtonState.enabled,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: state == QuickcountButtonState.outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(color: textColor ?? Colors.white),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 48),
                ),
              ),
              child: Text(
                text!,
                style: QuickCountTextStyles.body16Regular.copyWith(
                  height: 24 / 16,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ElevatedButton(
              onPressed: state == QuickcountButtonState.disabled
                  ? null
                  : onPressed,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.resolveWith<Color?>((states) {
                  if (state == QuickcountButtonState.disabled) {
                    return AppColors.backgroundDisabled;
                  } else {
                    return enabledBackgroundColor;
                  }
                }),
                foregroundColor:
                    WidgetStateProperty.resolveWith<Color?>((states) {
                  if (state == QuickcountButtonState.disabled) {
                    return AppColors.textDisabled;
                  } else {
                    return textColor;
                  }
                }),
                minimumSize:
                    WidgetStateProperty.all(const Size(double.infinity, 48)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              child: Text(
                text!,
                style: QuickCountTextStyles.body16Regular.copyWith(
                  height: 24 / 16,
                  color: state == QuickcountButtonState.disabled
                      ? const Color(0xFF9CA9B9)
                      : textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
