
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

  const TextWidget(
    this.title, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.fontSize,
    this.overflow,
    this.fontWeight,
    this.maxLines,
    this.fontFamily,
    this.color = AppColors.black,
    this.softWrap = true,
    this.style,
  });
  final String title;
 final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? fontSize;
  final TextOverflow? overflow;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLines;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      style: style ?? AppText.reg16.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
