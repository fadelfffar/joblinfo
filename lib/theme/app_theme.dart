import 'package:flutter/material.dart';

// ─── Colour tokens ────────────────────────────────────────────────────────────
const kColorPrimary = Color(0xFF2E7D5B);
const kColorAccent = Color(0xFFFFB020);
const kColorTextPrimary = Color(0xFF1A1A1A);
const kColorTextSecondary = Color(0xFF6B6B6B);
const kColorRejectionNeutral = Color(0xFF8A8A8A);
const kColorSurface = Color(0xFFF7F9F8);
const kColorCardBg = Colors.white;

// ─── Spacing tokens ───────────────────────────────────────────────────────────
const kSpace4 = 4.0;
const kSpace8 = 8.0;
const kSpace12 = 12.0;
const kSpace16 = 16.0;
const kSpace24 = 24.0;
const kSpace32 = 32.0;

// ─── Radius tokens ────────────────────────────────────────────────────────────
const kRadiusCard = 12.0;
const kRadiusButton = 8.0;

// ─── Type scale ───────────────────────────────────────────────────────────────
const kFontCaption = 12.0;
const kFontBody = 14.0;
const kFontSubtitle = 16.0;
const kFontTitle = 20.0;
const kFontHeading = 24.0;

// ─── MaterialTheme ────────────────────────────────────────────────────────────
ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: kColorPrimary,
    scaffoldBackgroundColor: kColorSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: kColorSurface,
      foregroundColor: kColorTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: kColorTextPrimary,
        fontSize: kFontTitle,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: kColorCardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusCard),
        side: BorderSide(color: Colors.grey.shade200),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusButton),
        ),
        textStyle: const TextStyle(
          fontSize: kFontBody,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kColorPrimary,
        side: const BorderSide(color: kColorPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusButton),
        ),
        textStyle: const TextStyle(
          fontSize: kFontBody,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: kColorPrimary,
      unselectedItemColor: kColorTextSecondary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    chipTheme: ChipThemeData(
      selectedColor: kColorPrimary.withAlpha(30),
      labelStyle: const TextStyle(fontSize: kFontCaption),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
          fontSize: kFontHeading,
          fontWeight: FontWeight.w700,
          color: kColorTextPrimary),
      titleMedium: TextStyle(
          fontSize: kFontTitle,
          fontWeight: FontWeight.w700,
          color: kColorTextPrimary),
      titleSmall: TextStyle(
          fontSize: kFontSubtitle,
          fontWeight: FontWeight.w600,
          color: kColorTextPrimary),
      bodyMedium: TextStyle(fontSize: kFontBody, color: kColorTextPrimary),
      bodySmall: TextStyle(fontSize: kFontCaption, color: kColorTextSecondary),
    ),
  );
}
