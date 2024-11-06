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
  final String? defaultValue;
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
  // obsecureText is to show/hide password
  final bool obscureText;
  // isObsecured is to show/hide password icon
  final bool isObsecured;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final bool isMandatory;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final FormType formType;
  final List<String> dropdownItems;
  final String? selectedDropdownItem;
  final ValueChanged<String?>? onDropdownChanged;
  final bool showDropdown;

  const QuickcountTextFormField({
    super.key,
    this.defaultValue,
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
    this.isObsecured = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.focusNode,
    this.isMandatory = false,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.formType = FormType.defaults,
    this.dropdownItems = const [],
    this.selectedDropdownItem,
    this.onDropdownChanged,
    this.showDropdown = false,
  });

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
    _obscureText = widget.obscureText;
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalController = widget.controller ?? TextEditingController(text: widget.defaultValue);
    _internalController.addListener(() {
      setState(() {});
    });

    _internalFocusNode.addListener(() {
      if (!_internalFocusNode.hasFocus) {
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
        if (widget.showDropdown)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: DropdownButtonFormField<String>(
              value: widget.selectedDropdownItem,
              hint: Text(
                  widget.inputLabel,
                  style: QuickCountTextStyles.body12Regular.copyWith(
                    color: AppColors.textDisabled,
                    height: 18 / 12,
                  ),
              ),
              isExpanded: true,
              onChanged: widget.enabled
                  ? (String? newValue) {
                setState(() {
                  widget.onDropdownChanged?.call(newValue);
                });
              }
                  : null,
              decoration: InputDecoration(
                hintText: widget.inputLabel,
                hintStyle: QuickCountTextStyles.body12Regular.copyWith(
                  color: AppColors.textDisabled,
                  height: 18 / 12,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Color(0xFFDAE0E9),
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide:
                  BorderSide(color: AppColors.strokeGray, width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      color: AppColors.strokeGray,
                      width: 1),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide:
                  BorderSide(color: Color(0xFFC4473B), width: 1),
                ),

              ),
              items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: QuickCountTextStyles.body12Regular.copyWith(
                      color: AppColors.textPrimary,
                      height: 18 / 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        if (!widget.showDropdown)
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: _obscureText ? 1 : widget.maxLines,
                minLines: widget.minLines,
                enabled: widget.enabled,
                controller: _internalController,
                focusNode: _internalFocusNode,
                autovalidateMode: widget.autovalidateMode,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: widget.inputLabel,
                  hintStyle: QuickCountTextStyles.body12Regular.copyWith(
                    color: AppColors.textDisabled,
                    height: 18 / 12,
                  ),
                  contentPadding: const EdgeInsets.only(left: 12.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color(0xFFDAE0E9),
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                    BorderSide(color: AppColors.strokeGray, width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        color: AppColors.strokeGray,
                        width: 1),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                    BorderSide(color: Color(0xFFC4473B), width: 1),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.clearable && _internalController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _internalController.clear();
                            if (widget.onChange != null) {
                              widget.onChange!('');
                            }
                          },
                        ),
                      if (widget.isObsecured)  IconButton(
                        icon: Text(_obscureText ? "Tampilkan" : "Sembunyikan"),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                keyboardType: widget.keyboardType,
                validator: widget.validator,
                inputFormatters: widget.inputFormatters,
                onChanged: widget.onChange,
              ),
            ),
            if (widget.suffix == SuffixType.unit) ...[
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEEF0),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                height: 48,
                child: Center(
                  child: Text(
                    widget.unitLabel,
                    style: QuickCountTextStyles.body16Regular.copyWith(
                      color: AppColors.textSecondary,
                      height: 24 / 16,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (widget.showHelper)
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              widget.helperLabel,
              style: QuickCountTextStyles.captionRegular.copyWith(
                color: AppColors.textSecondary,
                height: 24 / 12,
              ),
            ),
          ),
        if (widget.showCounter)
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              widget.counterLabel,
              style: QuickCountTextStyles.captionRegular.copyWith(
                color: AppColors.textSecondary,
                height: 24 / 12,
              ),
            ),
          ),
        if (widget.state == FieldState.error)
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              widget.errorLabel,
              style: QuickCountTextStyles.captionRegular.copyWith(
                color: AppColors.dangerMain,
                height: 24 / 12,
              ),
            ),
          ),
      ],
    );
  }
}