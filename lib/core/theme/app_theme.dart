import 'package:fixiez/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
        fillColor: AppColors.textfield,
        hintStyle: const TextStyle(color: AppColors.texthint92),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.texthint80),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),

  ); 
  
}