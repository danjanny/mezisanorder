import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../icons/icon_asset.dart';
import 'app_colors.dart';
import 'quickcount_text_styles.dart';

enum FieldState {
  defaultState,
  active,
  filled,
  error,
  disabled,
  disabledFilled
}

enum SuffixType { none, icon, unit }

enum PrefixType { number }

enum FormType { textarea, defaults }

class QuickcountTextFormField extends StatefulWidget {
  final bool enabled;
  final FieldState state;
  final PrefixType prefix;
  final SuffixType suffix;
  final String prefixLabel;
  final Widget? changeIcon;
  final String unitLabel;
  final bool showTitle;
  final String titleLabel;
  final String inputLabel;
  final bool additional;
  final bool showHelper;
  final String helperLabel;
  final bool showCounter;
  final String counterLabel;
  final String errorLabel;
  final EdgeInsets titleMargin;
  final bool prefixEnabled;
  final bool suffixEnabled;
  final ValueChanged<String>? onChange;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool clearable;
  final TextEditingController? controller;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final bool isMandatory;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final FormType formType;

  const QuickcountTextFormField(
      {super.key,
      this.enabled = true,
      this.state = FieldState.defaultState,
      this.prefix = PrefixType.number,
      this.suffix = SuffixType.none,
      this.prefixLabel = "+62",
      this.changeIcon,
      this.unitLabel = "xx",
      this.showTitle = true,
      this.titleLabel = "Title",
      this.inputLabel = "Label",
      this.additional = false,
      this.showHelper = false,
      this.helperLabel = "Helper",
      this.showCounter = false,
      this.counterLabel = "Counter",
      this.errorLabel = "Error message",
      this.titleMargin = const EdgeInsets.only(bottom: 4),
      this.prefixEnabled = false,
      this.suffixEnabled = false,
      this.onChange,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.clearable = false,
      this.controller,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.focusNode,
      this.isMandatory = false,
      this.inputFormatters,
      this.maxLines,
      this.minLines,
      this.formType = FormType.defaults});

  @override
  State<QuickcountTextFormField> createState() =>
      _QuickcountTextFormFieldState();
}

class _QuickcountTextFormFieldState extends State<QuickcountTextFormField> {
  late TextEditingController _internalController;
  late bool _obscureText;
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    _obscureText = widget.obscureText;
    _internalFocusNode = widget.focusNode ?? FocusNode();

    _internalController.addListener(() {
      setState(() {});
    });

    _internalFocusNode.addListener(() {
      if (!_internalFocusNode.hasFocus) {
        // Trigger validation when the field loses focus
        Form.of(context).validate();
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: widget.titleMargin,
                child: Text(
                  widget.titleLabel,
                  style: QuickCountTextStyles.body12Regular.copyWith(
                    height: 18 / 12,
                    color: widget.enabled
                        ? AppColors.textSecondary
                        : AppColors.neutral60,
                  ),
                ),
              ),
              if (widget.isMandatory)
                Text("*",
                    style: QuickCountTextStyles.captionRegular.copyWith(
                        color: widget.enabled
                            ? AppColors.dangerMain
                            : AppColors.dangerBorder,
                        fontSize: 12))
            ],
          ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLines: _obscureText ? 1 : widget.maxLines,
                    minLines: widget.minLines,
                    enabled: widget.enabled,
                    controller: _internalController,
                    focusNode: _internalFocusNode,
                    autovalidateMode: widget.autovalidateMode,
                    decoration: InputDecoration(
                      // Set the cursor color
                      focusColor: const Color(0xFFC4473B),
                      // Change to your desired color
                      prefix:
                          const Padding(padding: EdgeInsets.only(left: 12.0)),
                      hintText: widget.inputLabel,
                      hintStyle: QuickCountTextStyles.body12Regular.copyWith(
                        color: AppColors.textDisabled,
                        height: 18 / 12,
                      ),
                      contentPadding: widget.formType == FormType.defaults
                          ? const EdgeInsets.only(
                              left: 5.0) // Add left margin for cursor/text
                          : widget.formType == FormType.textarea
                              ? EdgeInsets.fromLTRB(12.0, 12.0, 16.0,
                                  12.0) // Add left margin for cursor/text
                              : const EdgeInsets.only(left: 12.0),
                      // Add left margin for cursor/text
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide: BorderSide(
                            color: Color(0xFFDAE0E9),
                            width: 1), // Set border color and width
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide:
                            BorderSide(color: AppColors.strokeGray, width: 1),
                      ),
                      // Set the unfocused border color (on blur)
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide: BorderSide(
                            color: AppColors.strokeGray,
                            width: 1), // Set border color and width
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide: BorderSide(
                            color: Color(0xFFDAE0E9),
                            width: 1), // Set border color and width
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide:
                            BorderSide(color: Color(0xFFC4473B), width: 1),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // Set border radius to 12px
                        borderSide:
                            BorderSide(color: Color(0xFFC4473B), width: 1),
                      ),
                      prefixIcon: widget.prefixEnabled
                          ? Container(
                              height: 48,
                              width: widget.prefixLabel == "Rp" ? 44 : 55,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xFFD9D9D9)),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.prefixLabel,
                                  style: widget.enabled
                                      ? GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 1.33,
                                          letterSpacing: 0.4,
                                          color: const Color(0xFF2C2C2C),
                                        )
                                      : QuickCountTextStyles.body16Regular
                                          .copyWith(
                                              height: 24 / 16,
                                              color: AppColors.neutral60),
                                ),
                              ),
                            )
                          : null,
                      suffixIcon: widget.clearable &&
                              _internalController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _internalController.clear();
                                if (widget.onChange != null) {
                                  widget.onChange!('');
                                }
                              },
                            )
                          : widget.suffixEnabled &&
                                  widget.suffix == SuffixType.icon
                              ? (widget.changeIcon != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: widget.changeIcon,
                                    )
                                  : null)
                              : widget.obscureText
                                  ? IconButton(
                                      icon: SvgPicture.asset(
                                        _obscureText
                                            ? IconAsset.obscureIconShow
                                            : IconAsset.obscureIconHide,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    )
                                  : null,
                      suffix: widget.suffixEnabled &&
                              widget.suffix == SuffixType.unit
                          ? Container(
                              width: 27,
                              height: 22,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: widget.state == FieldState.error
                                    ? const Color(0xFFE4A29E)
                                    : const Color(0xFF848484),
                              ),
                              child: Text(
                                widget.unitLabel,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.33,
                                  letterSpacing: 0.4,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : null,
                      helperText: widget.showHelper ? widget.helperLabel : null,
                      counterText:
                          widget.showCounter ? widget.counterLabel : null,
                      errorText: null,
                      errorStyle: QuickCountTextStyles.body10Regular.copyWith(
                        color: const Color(0xFFB90024),
                        height: 12 / 10,
                      ),
                      fillColor: widget.enabled == true
                          ? Colors.white
                          : const Color(0xFFDAE0E9),
                      // Set fill color to white
                      filled: true, // Ensure the fill color is applied
                    ),
                    style: widget.enabled
                        ? QuickCountTextStyles.body12Regular.copyWith(
                            color: AppColors.textPrimary, height: 18 / 12)
                        : QuickCountTextStyles.body16Regular.copyWith(
                            color: AppColors.neutral60,
                            height: 18 / 12,
                          ),
                    onChanged: widget.onChange,
                    keyboardType: widget.keyboardType,
                    validator: widget.validator,
                    obscureText: _obscureText,
                    inputFormatters: widget.inputFormatters,
                  ),
                  if (widget.state == FieldState.error)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text(
                        widget.errorLabel,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                          color: const Color(0xFFCF112B),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
