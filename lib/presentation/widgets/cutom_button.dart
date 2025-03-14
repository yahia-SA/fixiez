// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onpressed,
    this.backgroundColor,
    this.foregroundColor,
  });
  final String text;
  final VoidCallback onpressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 48.h,    
      child: ElevatedButton(onPressed: onpressed,
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor,
      foregroundColor:foregroundColor ,
),
 child: Text(text)));
  }
}
