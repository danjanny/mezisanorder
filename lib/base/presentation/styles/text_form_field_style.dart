import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextFormFieldStatus { defaultStatus, danger, disabled }

class TextFormFieldStyle {
  static InputDecoration getDecoration(
      TextFormFieldStatus status, String placeholder) {
    return InputDecoration(
      hintText: placeholder,
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        textBaseline: TextBaseline.alphabetic,
      ),
      filled: true,
      fillColor: _getFillColor(status),
      enabledBorder: _getBorder(status),
      focusedBorder: _getBorder(status),
      disabledBorder: _getBorder(status),
      contentPadding: const EdgeInsets.only(top: 12, left: 8),
    );
  }

  static InputDecorationTheme getDefaultInputDecorationTheme() {
    InputDecoration defaultDecoration =
        getDecoration(TextFormFieldStatus.defaultStatus, '');
    InputDecoration errorDecoration =
        getDecoration(TextFormFieldStatus.danger, '');
    InputDecoration disabledDecoration = getDecoration(
        TextFormFieldStatus.disabled, ''); // Added for disabled status

    return InputDecorationTheme(
      hintStyle: defaultDecoration.hintStyle,
      filled: defaultDecoration.filled!,
      fillColor: defaultDecoration.fillColor,
      contentPadding: defaultDecoration.contentPadding,
      border: defaultDecoration.enabledBorder,
      errorBorder: errorDecoration.errorBorder,
      focusedErrorBorder: errorDecoration.focusedErrorBorder,
      errorStyle: errorDecoration.errorStyle,
      disabledBorder:
          disabledDecoration.disabledBorder, // Added for disabled status
    );
  }

  static Color _getFillColor(TextFormFieldStatus status) {
    switch (status) {
      case TextFormFieldStatus.danger:
        return Colors.white;
      case TextFormFieldStatus.disabled:
        return Color(0xFFEDEDED);
      case TextFormFieldStatus.defaultStatus:
      default:
        return Colors.white;
    }
  }

  static OutlineInputBorder _getBorder(TextFormFieldStatus status) {
    Color borderColor;
    switch (status) {
      case TextFormFieldStatus.danger:
        borderColor = Color(0xFFCF112B);
        break;
      case TextFormFieldStatus.disabled:
        borderColor = Color(0xFFC2C2C2);
        break;
      case TextFormFieldStatus.defaultStatus:
      default:
        borderColor = Color(0xFFC2C2C2);
        break;
    }
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
    );
  }
}
