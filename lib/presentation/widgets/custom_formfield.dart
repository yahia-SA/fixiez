// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  });
  final TextEditingController controller;
  final TextInputType type;
  final String? hint;
  final String? Function(String?) validate;
  final IconData? suffix;
  final VoidCallback? suffixPressed;
  final bool isPassword;
final     List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textAlign: TextAlign.right,
      obscureText: isPassword,
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
        
      )
            : null,
            iconColor: AppColors.suffixIconColor
      ),
      validator: validate,
      
    
    );
  }
}
