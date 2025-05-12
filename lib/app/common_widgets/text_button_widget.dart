import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Size? minimumSize;
  final Color? backgroundColor;
  final String buttonText;
  final Color? textColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final BorderStyle borderStyle;
  final String? fontFamily;

  const TextButtonWidget({
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
    this.borderStyle = BorderStyle.none,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
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
          fontFamily:
              fontFamily, // Replace with FontFamily.Roboto.name if applicable
        ),
      ),
    );
  }
}
