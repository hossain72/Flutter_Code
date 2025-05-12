import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Size? minimumSize;
  final Color? backgroundColor;
  final String buttonText;
  final Color? textColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final BorderStyle borderStyle;

  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.minimumSize,
    this.backgroundColor,
    required this.buttonText,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.fontFamily,
    this.borderStyle = BorderStyle.none,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize ?? Size(width, 48.h),
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: 1.w,
            style: borderStyle,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: fontSize ?? 17.sp,
          color: textColor ?? Colors.white,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
