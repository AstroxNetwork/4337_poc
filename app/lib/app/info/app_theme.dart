import 'package:flutter/material.dart';

ThemeData get appThemeData => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
      ),
      textTheme: const TextTheme(),
      checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity(
          horizontal: 1,
          vertical: -1,
        ),
      ),
    );
