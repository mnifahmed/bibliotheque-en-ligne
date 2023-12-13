import 'package:flutter/material.dart';
import 'package:Bibliotheque/theme/colors.dart';

class Theme {
  static final ThemeData baseLight = ThemeData.light();
  static final ThemeData baseDark = ThemeData.dark();

  static ThemeData get lightTheme {
    return baseLight.copyWith(
      textTheme: _lightTextTheme,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kPrimaryColor,
      appBarTheme: _appBarTheme,
      floatingActionButtonTheme: _fabTheme, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor)
    );
  }

  static TextTheme get _lightTextTheme {
    return const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: kTextTitleColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 17.0,
        color: kGreyColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 17.0,
        color: kAccentColor,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 0,
      color: kPrimaryColor,
      iconTheme: const IconThemeData(
        color: kTextTitleColor,
      ), toolbarTextStyle: _lightTextTheme.copyWith(
        titleLarge: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kTextTitleColor,
        ),
      ).bodyMedium, titleTextStyle: _lightTextTheme.copyWith(
        titleLarge: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kTextTitleColor,
        ),
      ).titleLarge,
    );
  }

  static FloatingActionButtonThemeData get _fabTheme =>
      const FloatingActionButtonThemeData(backgroundColor: kAccentColor);

  static ThemeData get darkTheme {
    return baseDark.copyWith(
      textTheme: _darkTextTheme,
      primaryColor: kPrimaryColorDark,
      scaffoldBackgroundColor: kPrimaryColorDark,
      appBarTheme: _appBarThemeDark,
      floatingActionButtonTheme: _fabThemeDark, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColorDark)
    );
  }

  static TextTheme get _darkTextTheme {
    return const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 17.0,
        color: kGreyColorDark,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 17.0,
        color: kAccentColorDark,
      ),
    );
  }

  static FloatingActionButtonThemeData get _fabThemeDark =>
      const FloatingActionButtonThemeData(
          backgroundColor: kAccentColorDark, foregroundColor: Colors.white);

  static AppBarTheme get _appBarThemeDark {
    return AppBarTheme(
      elevation: 0,
      color: kPrimaryColorDark,
      iconTheme: const IconThemeData(
        color: kTextTitleColorDark,
      ), toolbarTextStyle: _darkTextTheme.copyWith(
        titleLarge: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kTextTitleColorDark,
        ),
      ).bodyMedium, titleTextStyle: _darkTextTheme.copyWith(
        titleLarge: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kTextTitleColorDark,
        ),
      ).titleLarge,
    );
  }
}
