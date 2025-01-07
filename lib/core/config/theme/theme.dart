import 'package:flutter/material.dart';
import '../../utils/res/resolution.dart';
import 'colors.dart';

var appTheme = ThemeData(
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    surface: AppColors.surfaceColor,
    onSurface: AppColors.onSurfaceColor,
    primaryContainer: AppColors.containerColor,
    onPrimaryContainer: AppColors.onSurfaceContainerColor,
  ),

    textTheme: TextTheme(
     headlineLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 3.6 * (AppResolution.textMultipler),
      fontWeight: FontWeight.bold,
      color: AppColors.onSurfaceColor,
    ),

    headlineMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 2.7 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: 2.1 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceColor,
    ),
    titleLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.9 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceColor,
    ),

    titleMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.9 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceColor,
    ),
    titleSmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.9 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceColor,
    ),
     bodyLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.7 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.7 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceColor,
    ),
    bodySmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.7 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceColor,
    ),
      labelLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.7 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceColor,
    ),
      labelMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.5 * (AppResolution.textMultipler),
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceColor,
    ),
    labelSmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: 1.5 * (AppResolution.textMultipler),
      fontWeight: FontWeight.normal,
      color: AppColors.onSurfaceColor,
    ),
  ),
);