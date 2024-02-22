import 'package:flutter/material.dart';

class ThemeShifter {
  static ThemeData lightTheme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      constraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: double.infinity,
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      hintStyle: TextStyle(
        color: Color.fromARGB(255, 210, 209, 209),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFamily: "universal_font",
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: "universal_font",
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: "universal_font",
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: Colors.green,
        foregroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(primary: Colors.green),
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
  );

  static ThemeData darkTheme = ThemeData.dark(
    
  );
}
