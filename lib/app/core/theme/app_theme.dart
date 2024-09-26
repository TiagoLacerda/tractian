import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get theme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF2188FF),
      brightness: Brightness.light,
      primary: const Color(0xFF2188FF),
      onPrimary: Colors.white,
      surfaceTint: Colors.transparent,
    );

    final typography = Typography.material2021();

    var textTheme = typography.englishLike.merge(typography.black);

    textTheme = textTheme.copyWith(
      labelLarge: textTheme.labelLarge?.copyWith(
        fontSize: 14.0,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: 14.0,
      ),
    );

    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme,
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF17192D),
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2188FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFF2188FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF77818C),
          side: const BorderSide(
            color: Color(0xFFD8DFE6),
            width: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          padding: const EdgeInsets.only(
            top: 6.0,
            right: 16.0,
            bottom: 6.0,
            left: 14.0,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
