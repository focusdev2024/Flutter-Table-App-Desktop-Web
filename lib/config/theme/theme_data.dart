import 'package:flutter/material.dart';
import 'package:responsible_unicorn/constants/app_color.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.appColor,
    scaffoldBackgroundColor: AppColors.appColor,
    cardTheme: CardTheme(
      color: AppColors.appColor,
      // shadowColor: AppColors.grey,
      // elevation: 5,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.appColor,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: IconThemeData(color: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: TextStyle(color: AppColors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: AppColors.appColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      prefixIconColor: AppColors.grey,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
    ),

    dividerColor: AppColors.black,
    indicatorColor: AppColors.red,
  );

  static final ThemeData darkTheme = ThemeData();
}
