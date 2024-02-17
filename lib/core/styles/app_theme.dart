import 'package:flutter/material.dart';

import 'values/colors.dart';

class MaterialAppTheme {
  static AppBarTheme appBarTheme = const AppBarTheme(
    backgroundColor: AppColors.primary,
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 70,
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
    foregroundColor: AppColors.white,
    actionsIconTheme: IconThemeData(
      color: AppColors.white,
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.buttomColor,
      foregroundColor: AppColors.white,
      elevation: 0.0,
      shape: const StadiumBorder(),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      shape: const StadiumBorder(),
      side: const BorderSide(color: AppColors.primary),
    ),
  );

  static DropdownMenuThemeData dropdownMenuThemeData = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: AppColors.primary,
      fillColor: AppColors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.greyDark),
        borderRadius: BorderRadius.circular(5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
    ),
  );

  static ThemeData mainThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.red)),
        filled: true,
        fillColor: AppColors.textFormFieldBG,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none)),
    dropdownMenuTheme: dropdownMenuThemeData,
    primaryColor: AppColors.primary,
    primarySwatch: AppColors.primarySwatch,
    appBarTheme: appBarTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    elevatedButtonTheme: elevatedButtonTheme,
  );
}
