import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/config/themes/colors.dart';

class CustomThemes {
  static const radiusSize = 5.0;
  static const borderRadius = BorderRadius.all(Radius.circular(radiusSize));

  static const textStyle = TextStyle(
    color: MyColors.neutral35,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  final defaultTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.neutral90,
    primaryColor: MyColors.amber,
    dividerColor: Colors.transparent,
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.amber,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColors.neutral30,
      ),
    ),
    fontFamily: 'Montserrat',
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shadowColor: WidgetStateProperty.all(MyColors.hover),
        overlayColor: WidgetStateProperty.all(MyColors.hover),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyColors.primary,
      selectionColor: MyColors.primary.withValues(alpha: 0.4),
      selectionHandleColor: MyColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyColors.neutral30.withValues(alpha: 0.04),
      filled: true,
      iconColor: MyColors.neutral50,
      prefixIconColor: MyColors.neutral50,
      suffixIconColor: MyColors.neutral50,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      enabledBorder: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: MyColors.neutral60,
          width: 1.3,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          width: 1.3,
        ),
      ),
      labelStyle: const TextStyle(color: MyColors.neutral40, fontSize: 14.0),
      hintStyle: const TextStyle(color: Colors.red, fontSize: 16.0),
      counterStyle: const TextStyle(color: Colors.red, fontSize: 14.0),
      suffixStyle: const TextStyle(color: Colors.red, fontSize: 14.0),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.neutral90,
      iconTheme: IconThemeData(color: MyColors.black),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.neutral30,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.amber,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.black,
      ),
    ),
    cardColor: MyColors.neutral80,
    cardTheme: const CardTheme(
      color: MyColors.neutral80,
      elevation: 5.0,
      shadowColor: MyColors.neutral60,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: MyColors.neutral60,
          width: 1.1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        //backgroundColor: WidgetStateProperty.all(MyColors.primary),
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
            return MyColors.neutral60;
          }
          return Colors.transparent;
        },
      ),
      checkColor: WidgetStateProperty.all(MyColors.white),
      overlayColor:
          WidgetStateProperty.all(MyColors.primary.withValues(alpha: 0.1)),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: MyColors.neutral60,
          width: 1.1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyColors.secondary,
      circularTrackColor: MyColors.neutral60,
      linearMinHeight: 4.0,
      linearTrackColor: MyColors.neutral60,
      refreshBackgroundColor: MyColors.neutral90,
    ),
    dialogTheme: DialogThemeData(backgroundColor: MyColors.neutral90),
  );
}
