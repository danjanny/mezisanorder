import 'package:flutter/material.dart';

class QuickcountLoadingDialog extends StatelessWidget {
  const QuickcountLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: Color(0xFFCD121A),
            ),
          ),
        ),
      ),
    );
  }

  static void showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return const QuickcountLoadingDialog();
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
