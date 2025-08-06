import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/config/themes/colors.dart';

class CustomThemes {
  static const radiusSize = 5.0;
  static const borderRadius = BorderRadius.all(Radius.circular(radiusSize));

  static const textStyle = TextStyle(
    color: MyColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  final defaultTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.background,
    primaryColor: MyColors.primary,
    dividerColor: Colors.transparent,
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.secondary,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColors.white,
      ),
    ),
    fontFamily: 'Montserrat',
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shadowColor:
            WidgetStateProperty.all(MyColors.white.withValues(alpha: 0.2)),
        overlayColor:
            WidgetStateProperty.all(MyColors.white.withValues(alpha: 0.2)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyColors.primary,
      selectionColor: MyColors.primary.withValues(alpha: 0.4),
      selectionHandleColor: MyColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyColors.black.withValues(alpha: 0.04),
      filled: true,
      iconColor: MyColors.white,
      prefixIconColor: MyColors.black.withValues(alpha: 0.4),
      suffixIconColor: MyColors.black.withValues(alpha: 0.4),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: MyColors.alert.withValues(alpha: 0.4),
          width: 1.3,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: MyColors.white,
          width: 1.3,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          width: 1.3,
        ),
      ),
      labelStyle: const TextStyle(color: MyColors.white, fontSize: 14.0),
      hintStyle: TextStyle(
          color: MyColors.black.withValues(alpha: 0.4), fontSize: 16.0),
      counterStyle: const TextStyle(color: MyColors.error, fontSize: 14.0),
      suffixStyle: const TextStyle(color: MyColors.error, fontSize: 14.0),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.background,
      iconTheme: IconThemeData(color: MyColors.black),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.secondary,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
    ),
    cardColor: MyColors.black,
    cardTheme: const CardTheme(
      color: MyColors.black,
      elevation: 5.0,
      shadowColor: MyColors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: MyColors.white,
          width: 1.1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColors.white),
        overlayColor:
            WidgetStateProperty.all(MyColors.primary.withValues(alpha: 0.1)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Montserrat',
            color: MyColors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return MyColors.white;
          }
          return Colors.transparent;
        },
      ),
      checkColor: WidgetStateProperty.all(MyColors.black),
      overlayColor:
          WidgetStateProperty.all(MyColors.primary.withValues(alpha: 0.1)),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: MyColors.white,
          width: 1.1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyColors.secondary,
      circularTrackColor: MyColors.white,
      linearMinHeight: 4.0,
      linearTrackColor: MyColors.white,
      refreshBackgroundColor: MyColors.black,
    ),
    dialogTheme: DialogThemeData(backgroundColor: MyColors.black),
  );
}
