import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';
class AppTheme {
  static _border([Color color = dividerColor]) => OutlineInputBorder(
      borderSide: BorderSide(
          color: color,
          width: 2
      ),
      borderRadius: BorderRadius.circular(10)
  );
  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarColor,
      ),
      chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll(backgroundColor),
        side: BorderSide.none,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: _border(),
        focusedBorder: _border(tabColor),
        errorBorder: _border(Colors.red),
      )
  );
}