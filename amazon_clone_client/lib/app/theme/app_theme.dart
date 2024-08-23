import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  // static const appBarGradient = LinearGradient(
  //   AppColors.appBarGradientColors,
  //   stops: [0.5, 1.0],
  // );

  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.appBarIconColor,
      ),
    ),
  );
}
