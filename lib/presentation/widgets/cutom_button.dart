// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    required this.onpressed,
    this.backgroundColor,
    this.foregroundColor,
    this.widget,
  });
  final String? text;
  final VoidCallback onpressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child:
        widget ?? 
         TextWidget(text ?? '', style: AppText.semi16),
      ),
    );
  }
}
