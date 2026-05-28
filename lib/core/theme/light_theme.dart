import 'package:clima_app/core/colors/app_colors_light.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ColorScheme colorScheme = ColorScheme.light(
  onPrimary: AppColorsLight.onPrimary,
  primary: AppColorsLight.primary,
);

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Outfit',
      colorScheme: colorScheme,
      textTheme: TextTheme(
        labelSmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 44.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        displayLarge: TextStyle(
          fontSize: 48.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
