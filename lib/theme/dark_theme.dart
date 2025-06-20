import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: const Color(0xFF0560A4),
  primaryColorLight: const Color(0xFFF0F4F8),
  primaryColorDark: const Color(0xFF10324A),
  secondaryHeaderColor: const Color(0xFF8797AB),
  cardColor: const Color(0xFF10324a),

  disabledColor: const Color(0xFF484848),
  scaffoldBackgroundColor: const Color(0xFF010d15),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFFFFFFF),
  focusColor: const Color(0xFF484848),
  hoverColor: const Color(0xFFABA9A7),
  shadowColor: const Color(0xFF4a5361), colorScheme: const ColorScheme.dark(
    primary: Color(0xFF02385F),
    secondary: Color(0xFFf57d00),
    tertiary: Color(0xFFFF6767),
    surfaceTint: Color(0xff158a52)
).copyWith(surface: const Color(0xFF010d15)).copyWith(error: const Color(0xFFdd3135)),

);
