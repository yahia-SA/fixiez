import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomFormfield extends StatelessWidget {
  const CustomFormfield({
    super.key,
    required this.controller,
    required this.type,
    this.hint,
    required this.validate,
    this.suffix,
    this.suffixPressed,
    this.isPassword = false,
    this.inputFormatters,
    required this.label,
  });
  final TextEditingController controller;
  final TextInputType type;
  final String? hint;
  final String? Function(String?) validate;
  final IconData? suffix;
  final VoidCallback? suffixPressed;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.med14Black),
        SizedBox(height: 12.h),
        SizedBox(
          width: 327.w,
          height: 48.h,
          child: TextFormField(
            controller: controller,
            keyboardType: type,
            textAlign: TextAlign.right,
            obscureText: isPassword,
            style: context.med14Black,
            inputFormatters: inputFormatters,
          textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(suffix,size: 18.h,),
              
            )
                  : null,
            ),
            validator: validate,
            
          
          ),
        ),
      ],
    );
  }
}
