import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.black,
    appBarTheme: AppBarTheme(
      color: ColorsManager.black,
      centerTitle: true,
      titleTextStyle: FontsManager.lexendBold(size: 25),
      foregroundColor: Colors.white,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: FontsManager.lexendRegular(color: ColorsManager.offWhite),

      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      filled: true,
      fillColor: ColorsManager.darkGreen,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.borderGreen),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorsManager.darkGreen,
      labelTextStyle: WidgetStatePropertyAll(
        FontsManager.lexendRegular(size: 14),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: ColorsManager.black,
      titleTextStyle: FontsManager.lexendBold(size: 22),
      contentTextStyle: FontsManager.lexendRegular(size: 14),
    ),
  );
}
