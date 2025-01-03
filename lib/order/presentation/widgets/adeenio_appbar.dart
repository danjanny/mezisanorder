import 'package:flutter/material.dart';
import 'package:skeleton/base/presentation/styles/text_styles.dart';

import '../../../base/presentation/textformfield/app_colors.dart';

enum AdeenioAppbarState { defaults, columnTitle }

class AdeenioAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Widget? leadingIconButton;
  final AdeenioAppbarState? state;
  final Widget? customWidget; // New named parameter for custom widget
  final List<Widget>? actions;

  const AdeenioAppbar(
      {super.key,
      this.state = AdeenioAppbarState.defaults,
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
      centerTitle: true,
      leading: leadingIconButton ??
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF181C21),
            ),
            onPressed: onBack,
          ),
      title: state == AdeenioAppbarState.defaults
          ? Text(title ?? '',
              textAlign: TextAlign.center,
              style: TextStyles.body16Regular.copyWith(
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
