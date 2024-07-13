import 'package:flutter/material.dart';

final ColorScheme kColorScheme =
    ColorScheme.fromSeed(seedColor: Color(0xff274c77));

var appTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Satoshi',
  colorScheme: kColorScheme,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Satoshi'),
    bodyMedium: TextStyle(fontFamily: 'Satoshi'),
    titleMedium: TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.w500),
    displayLarge: TextStyle(fontFamily: 'Satoshi'),
    displayMedium: TextStyle(fontFamily: 'Satoshi'),
    displaySmall: TextStyle(fontFamily: 'Satoshi'),
    headlineMedium: TextStyle(fontFamily: 'Satoshi'),
    headlineSmall: TextStyle(fontFamily: 'Satoshi'),
    headlineLarge: TextStyle(fontFamily: 'Satoshi'),
    bodySmall: TextStyle(fontFamily: 'Satoshi'),
    labelLarge: TextStyle(fontFamily: 'Satoshi', fontSize: 16),
    labelMedium: TextStyle(fontFamily: 'Satoshi', fontSize: 16),
    labelSmall: TextStyle(fontFamily: 'Satoshi', fontSize: 13.5),
  ),
);

const Color primaryColor = Color(0xff274c77);
const Color secondaryColor = Color(0xff4f749f);
const Color bgColor = Color(0xfff0f4f9);
const Color outlineColor = Color(0xffE4E4E4);
const Color highlightColor = Color(0xffF8FDFF);
