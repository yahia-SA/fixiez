import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixiez/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData appTheme =ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  hintColor: AppColors.texthint92,
  scaffoldBackgroundColor: AppColors.white,
        textTheme: TextTheme(
          //  Bold Blue
        displayLarge: AppText.bold28.copyWith(color: AppColors.primary),
        displayMedium: AppText.extraBold24.copyWith(color: AppColors.primary),
        displaySmall: AppText.bold20.copyWith(color: AppColors.primary),
        headlineLarge: AppText.bold16.copyWith(color: AppColors.primary),
        headlineMedium: AppText.bold14.copyWith(color: AppColors.primary),
        // headlineSmall: AppText.bold20.copyWith(color: AppColors.primary),
        
        // Error Red med14
        titleLarge: AppText.med14.copyWith(color: AppColors.error),
        // title med14 black
        titleMedium: AppText.med14.copyWith(color: AppColors.black),
        // texthint92 text spain
        titleSmall: AppText.reg14.copyWith(color: AppColors.texthint92),
        // body gray
        bodyLarge: AppText.reg16.copyWith(color: AppColors.texthint80),
        // feadback color
        bodyMedium: AppText.reg16.copyWith(color: AppColors.feadbackColor),
        

        // bodySmall: AppText.reg12.copyWith(color: AppColors.texthint80),
        
        labelLarge: AppText.reg16.copyWith(color: AppColors.texthint92),
        
        // labelMedium: AppText.reg14.copyWith(color: AppColors.texthint80),
        
        // labelSmall: AppText.reg12.copyWith(color: AppColors.texthint80),
        ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:  AppColors.black,
        suffixIconColor: AppColors.suffixIconColor,
        hintStyle: AppText.med14.copyWith(color: AppColors.texthint92),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: const BorderSide(color: AppColors.texthint80),
          
        ),
      ),
      
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          textStyle: AppText.medium20,
        ),
      )

  ); 
  
}