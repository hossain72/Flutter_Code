import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final String? hintText;
  final FormFieldValidator<String> validator;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enable;
  final Color? fillColor;
  final bool? readOnly;
  final int? maxLength;
  final Iterable<String>? autofillHint;
  final Color? enabledBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final double? errorFontSize;
  final int? errorMaxLine;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final String? fontFamily;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.validator,
    this.prefixIcon,
    this.maxLines,
    this.hintText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.obscureText,
    this.suffix,
    this.enable,
    this.fillColor,
    this.readOnly,
    this.maxLength,
    this.enabledBorderColor,
    this.autofillHint,
    this.contentPadding,
    this.prefix,
    this.inputFormatters,
    this.errorText,
    this.errorFontSize,
    this.errorMaxLine,
    this.onChange,
    this.focusNode,
    this.onTap,
    this.autoFocus,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onTap: onTap,
      autofocus: autoFocus ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHint,
      onChanged: onChange,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted:
          onFieldSubmitted ??
          (value) {
            return;
          },
      controller: controller,
      enabled: enable,
      keyboardType: textInputType,
      obscureText: obscureText ?? false,
      validator: validator,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 20.r,
              vertical: suffix == null ? 13.5.r : 10.r,
            ),
        fillColor: fillColor ?? Colors.white,
        isDense: true,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.h,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontFamily: fontFamily,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        prefix: prefix,
        errorText: errorText,
        errorMaxLines: errorMaxLine ?? 1,
        errorStyle: TextStyle(
          fontSize: errorFontSize ?? 12.h,
          color: Colors.red,
          fontFamily: fontFamily,
          letterSpacing: -0.4,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabledBorderColor ?? Colors.black,
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.h),
          borderRadius: BorderRadius.circular(8.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.h),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.h),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
