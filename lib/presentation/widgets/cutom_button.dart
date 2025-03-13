import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onpressed});
  final String text;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 48.h,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
    ),
      child: ElevatedButton(onPressed: onpressed, child: Text(text),));
  }
}