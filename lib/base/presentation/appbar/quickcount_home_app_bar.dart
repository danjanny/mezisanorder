import 'package:flutter/material.dart';

import '../textformfield/app_colors.dart';

enum QuickcountHomeAppBarState { defaults, columnTitle }

class QuickcountHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Widget? leadingIconButton;
  final QuickcountHomeAppBarState? state;
  final Widget? customWidget; // New named parameter for custom widget
  final List<Widget>? actions;

  const QuickcountHomeAppBar(
      {super.key,
      this.state = QuickcountHomeAppBarState.defaults,
      this.title,
      this.leadingIconButton,
      this.titleColor = const Color(0xFF181C21),
      this.backgroundColor = AppColors.neutral10,
      this.customWidget,
      this.actions = const []}); // Initialize customWidget

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false, // Disable the default back arrow
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
