import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final TextDecoration? decoration;
  final int? maxLine;
  final double? lineHeight;
  final FontStyle? fontStyle;

  const TextWidget({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.textOverflow,
    this.softWrap,
    this.decoration,
    this.maxLine,
    this.lineHeight,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: textOverflow,
      maxLines: maxLine,
      style: TextStyle(
        height: lineHeight,
        decoration: decoration ?? TextDecoration.none,
        color: textColor,
        letterSpacing: -0.4,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
    );
  }
}
