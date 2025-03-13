import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixiez/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData appTheme =ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  hintColor: AppColors.texthint92,
  scaffoldBackgroundColor: AppColors.white,
        textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.black, fontSize: 18),
        bodyMedium: TextStyle(color: AppColors.texthint80, fontSize: 16),
        bodySmall: TextStyle(color: AppColors.texthint92, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.black,
        hintStyle: const TextStyle(color: AppColors.texthint80),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: const BorderSide(color: AppColors.texthint80),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),

  ); 
  
}