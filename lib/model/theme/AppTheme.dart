import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // light dark

  static ThemeMode themeMode = ThemeMode.light;

  static final ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      primary: ColorsManager.lightPrimary,
      onPrimary: ColorsManager.lightPrimary,
      onPrimaryContainer: ColorsManager.whiteColor,
      tertiary: ColorsManager.lightFieldBorderColor,
      inversePrimary: Colors.white,
      primaryContainer:ColorsManager.lightBackground,
      onSecondary: ColorsManager.borderSideLight,
      onPrimaryFixed:ColorsManager.whiteColor,
      onPrimaryFixedVariant: ColorsManager.unSelectedNavigation,

    ),
    scaffoldBackgroundColor: ColorsManager.lightBackground,
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontWeight: .w600,
        fontSize: 20,
        color: ColorsManager.blackColor,
      ),
      titleSmall: TextStyle(
        fontWeight: .w400,
        fontSize: 16,
        color: Color(0xff686868),
      ),
      bodySmall: TextStyle(
        fontWeight: .w500,
        fontSize: 18,
        color: Color(0xff0E3A99),
      ),
      labelMedium: TextStyle(
        fontWeight: .w600,
        fontSize: 14,
        color: Color(0xffFFFFFF),
      ),
      labelSmall: TextStyle(
        fontWeight: .w400,
        fontSize: 14,
        color: Color(0xff0E3A99),
      ),
      displaySmall: TextStyle(
        fontWeight: .w400,
        fontSize: 14,
        color: ColorsManager.lightSecondaryColor,
      ),
      bodyMedium: TextStyle(
        color: ColorsManager.blackColor,
        fontSize: 16,
        fontWeight: .w500
      ),
      titleLarge: TextStyle(
        color: ColorsManager.lightPrimary,
        fontSize: 14,
        fontWeight: .w400
      )
    ),
  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: ColorsManager.darkPrimary,
      onPrimary: ColorsManager.whiteColor,
      onPrimaryContainer: Color(0xff001440),
      tertiary: ColorsManager.darkFieldBorderColor,
      inversePrimary: ColorsManager.darkBackground,
      primaryContainer:ColorsManager.darkBackground,
      onSecondary: ColorsManager.borderSideDark,
      onPrimaryFixed:ColorsManager.darkUnselectedSettings,
      onPrimaryFixedVariant: ColorsManager.lightBackground,

    ),
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontWeight: .w600,
        fontSize: 20,
        color: ColorsManager.whiteColor,
      ),
      titleSmall: TextStyle(
        fontWeight: .w400,
        fontSize: 16,
        color: Color(0xffD6D6D6),
      ),
      bodySmall: TextStyle(
        fontWeight: .w500,
        fontSize: 18,
        color: Color(0xffFFFFFF),
      ),
      labelMedium: TextStyle(
        fontWeight: .w600,
        fontSize: 14,
        color: Color(0xffFFFFFF),
      ),
      labelSmall: TextStyle(
        fontWeight: .w400,
        fontSize: 14,
        color: Color(0xffFFFFFF),
      ),
      displaySmall: TextStyle(
        fontWeight: .w400,
        fontSize: 14,
        color: ColorsManager.darkSecondaryColor,
      ),
        bodyMedium: TextStyle(
            color: ColorsManager.whiteColor,
            fontSize: 16,
            fontWeight: .w500
        ),
        titleLarge: TextStyle(
            color: ColorsManager.darkPrimary,
            fontSize: 14,
            fontWeight: .w400
        )

    ),
  );
}
