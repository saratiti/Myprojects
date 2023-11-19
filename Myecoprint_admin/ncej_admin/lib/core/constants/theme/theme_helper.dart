import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';

String _appTheme = "primary";

class ThemeHelper {

  final Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

 
  PrimaryColors _getThemeColors() {
  
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }


    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }


  ThemeData _getThemeData() {
  
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }


    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: colorScheme.primary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.whiteA700,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
        side: const BorderSide(
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appTheme.gray40001,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.lightGreen500,
      ),
    );
  }

  PrimaryColors themeColor() => _getThemeColors();
  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.gray700,
          fontSize: 15.fSize,
          fontFamily: 'FF Shamel Family',
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          color: appTheme.lightGreen500,
          fontSize: 11.fSize,
          fontFamily: 'FF Shamel Family',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 34.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: appTheme.lightGreen500,
          fontSize: 31.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 29.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: appTheme.red700,
          fontSize: 24.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 12.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 11.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 9.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 16.fSize,
          fontFamily: 'Bahij TheSansArabic',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      );
}
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFFA7A9AC),
    primaryContainer: Color(0XFF292D32),
    secondary: Color(0XFF292D32),
    secondaryContainer: Color(0XFFA7A9AC),
    tertiary: Color(0XFF292D32),
    tertiaryContainer: Color(0XFFA7A9AC),
    background: Color(0XFF292D32),
    surface: Color(0XFF292D32),
    surfaceTint: Color(0XFF2C2C2C),
    surfaceVariant: Color(0XFFA7A9AC),


    error: Color(0XFF2C2C2C),
    errorContainer: Color(0XFFA7A9AC),
    onError: Color(0X3F000000),
    onErrorContainer: Color(0XFF2C2C2C),


    onBackground: Color(0X3F000000),
    onInverseSurface: Color(0X3F000000),
    onPrimary: Color(0XFF2C2C2C),
    onPrimaryContainer: Color(0X3F000000),
    onSecondary: Color(0X3F000000),
    onSecondaryContainer: Color(0XFF2C2C2C),
    onTertiary: Color(0X3F000000),
    onTertiaryContainer: Color(0XFF2C2C2C),

    outline: Color(0XFF2C2C2C),
    outlineVariant: Color(0XFF292D32),
    scrim: Color(0XFF292D32),
    shadow: Color(0XFF2C2C2C),
    inversePrimary: Color(0XFF292D32),
    inverseSurface: Color(0XFF2C2C2C),
    onSurface: Color(0X3F000000),
    onSurfaceVariant: Color(0XFF2C2C2C),
  );
}

class PrimaryColors {
  Color get blueGray100 => const Color(0XFFD9D9D9);
  Color get blueGray400 => const Color(0XFF888888);
  Color get gray100 => const Color(0XFFF6F6F6);
  Color get gray400 => const Color(0XFFB3B3B3);
  Color get gray40001 => const Color(0XFFBBB8B8);
  Color get gray50 => const Color(0XFFFFFAFA);
  Color get gray700 => const Color(0XFF545454);
  Color get indigo800 => const Color(0XFF1F4386);
  Color get lightGreen500 => const Color(0XFF99CA3C);
  Color get lightGreen700 => const Color(0XFF6C8C30);
  Color get red700 => const Color(0XFFED1C24);
  Color get whiteA700 => const Color(0XFFFFFFFF);
}
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
