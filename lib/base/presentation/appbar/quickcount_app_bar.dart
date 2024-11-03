import 'package:flutter/material.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_styles.dart';

import '../textformfield/app_colors.dart';

enum QuickcountAppBarState { defaults, columnTitle }

class QuickcountAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Widget? leadingIconButton;
  final QuickcountAppBarState? state;
  final Widget? customWidget; // New named parameter for custom widget
  final List<Widget>? actions;

  const QuickcountAppBar(
      {super.key,
      this.state = QuickcountAppBarState.defaults,
      this.title,
      this.onBack,
      this.leadingIconButton,
      this.titleColor = const Color(0xFF181C21),
      this.backgroundColor = AppColors.backgroundSolidDefault,
      this.customWidget,
      this.actions = const []}); // Initialize customWidget

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF181C21),
              ),
              onPressed: onBack,
            )
          : null,
      centerTitle: true,
      // Add this line to center the title
      title: state == QuickcountAppBarState.defaults
          ? Text(title ?? '',
              textAlign: TextAlign.center,
              style: QuickCountTextStyles.body16Regular.copyWith(
                color: titleColor,
                height: 24 / 16,
              ))
          : customWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
