import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  // Med 14 g/L
  static TextStyle get med14 => GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500, // Medium
    height: 1.0.h,
  );
  // Med 12 g/L
  static TextStyle get med12 => GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500, // Medium
    height: 1.3.h,
  );
  // Reg 16 g/L
  static TextStyle get reg16 => GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0.h,
  );

  // Reg 14 g/L
  static TextStyle get reg14 => GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0.h,
  );
  // Reg 12 g/L
    static TextStyle get reg12 => GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0.h,
  );
  // Reg 12 g/L
    static TextStyle get reg10 => GoogleFonts.cairo(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400, // Regular
    height: 1.3.h,
  );


  // Semi 16 g/L
  static TextStyle get semi16 => GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.0.h,
  );

  // Bold 16 g/L
  static TextStyle get bold16 => GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );

  // Bold 14 g/L
  static TextStyle get bold14 => GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );
  // Bold 12 g/L
  static TextStyle get bold12 => GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );
  // Bold 20 g/L
  static TextStyle get bold20 => GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );

  // Med 20 g/L
  static TextStyle get medium20 => GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500, // Medium
    height: 1.0.h,
  );

  // Med 24 g/L
  static TextStyle get med24 => GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500, // Medium
    height: 1.0.h,
  );

  // Bold 24 g/L
  static TextStyle get bold24 => GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );

  // ExtraBold 24 g/L
  static TextStyle get extraBold24 => GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.w800, // ExtraBold
    height: 1.0.h,
  );

  // Bold 28 g/L

  static TextStyle get bold28 => GoogleFonts.cairo(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0.h,
  );
}

extension AppTextTheme on BuildContext {
  TextStyle? get bold28Blue => Theme.of(this).textTheme.displayLarge;

  TextStyle? get extraBold24Blue => Theme.of(this).textTheme.displayMedium;
  TextStyle? get bold24Blue => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get bold20Blue => Theme.of(this).textTheme.displaySmall;

  TextStyle? get bold16Blue => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get bold14Blue => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get error => Theme.of(this).textTheme.titleLarge;

  TextStyle? get med14Black => Theme.of(this).textTheme.titleMedium;

  TextStyle? get reg14Hint92 => Theme.of(this).textTheme.titleSmall;

  TextStyle? get reg16Hint80 => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get feedback => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get reg16Hint92 => Theme.of(this).textTheme.labelLarge;

}
