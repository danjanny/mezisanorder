import 'package:flutter/material.dart';

import '../../../base/presentation/textformfield/app_colors.dart';

class AdeenioScrollableWidget extends StatelessWidget {
  final bool formEnabled;
  final GlobalKey<FormState>? formKey;
  final List<Widget> children;

  const AdeenioScrollableWidget(
      {super.key,
      this.formEnabled = false,
      this.formKey,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.backgroundSolidDefault,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: formEnabled
              ? Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
        ),
      ),
    );
  }
}
