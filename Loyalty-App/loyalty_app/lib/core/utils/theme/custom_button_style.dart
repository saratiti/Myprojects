import 'package:flutter/material.dart';
import '../../app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepOrange800,
        foregroundColor: Colors.white, // Set text color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.h),
        ),
      );
  static ButtonStyle get fillWhiteA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        foregroundColor: Colors.white, // Set text color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  // Outline button style
  static ButtonStyle get outlineBlue => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepOrange800,
        foregroundColor: Colors.white, // Set text color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.h),
        ),
        elevation: 10,
      );
  static ButtonStyle get outlineBlueTL27 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepOrange800,
        foregroundColor: Colors.white, // Set text color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27.h),
        ),
        shadowColor: appTheme.deepOrange800,
        elevation: 10,
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
