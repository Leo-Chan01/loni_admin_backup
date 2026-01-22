import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'dimens.dart';

class AppTheme {
  static final AppTheme instance = AppTheme._();
  AppTheme._();

  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandAccent,
        brightness: Brightness.light,
        primary: AppColors.brandAccent,
        secondary: AppColors.brandTerracotta,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.lightText,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.lightBg,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.lightText,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandAccent,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.brandAccent.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brandAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: Dimens.mediumSizeText.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.lightTextMuted,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.brandAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.02),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandAccent,
        brightness: Brightness.dark,
        primary: AppColors.brandAccent,
        secondary: AppColors.brandTerracotta,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.darkText,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBg,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandAccent,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.brandAccent.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brandAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: Dimens.mediumSizeText.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.darkTextMuted,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.brandAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: AppColors.darkSurface.withValues(alpha: 0.5),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
      ),
    );
  }
}
