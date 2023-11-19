import 'package:flutter/material.dart';
import 'package:my_eco_print/core/constants/theme/theme_helper.dart';
import 'package:my_eco_print/core/utils/size_utils.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Bahij text style
  static get bahijTheSansArabicOnPrimary => TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w500,
      ).bahijTheSansArabic;
  static get bahijTheSansArabicWhiteA700 => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w500,
      ).bahijTheSansArabic;
  // Body text style
  static get bodyMediumLightgreen500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.lightGreen500,
      );
  static get bodyMediumQatar2022Arabic =>
      theme.textTheme.bodyMedium!.qatar2022Arabic.copyWith(
        fontWeight: FontWeight.w100,
      );
  static get bodySmallReadexPro => theme.textTheme.bodySmall!.readexPro;
  // Display text style
  static get displaySmallRed700 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.red700,
      );
  // Headline text style
  static get headlineLargeIndigo800 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.indigo800,
      );
  static get headlineLargeIndigo800_1 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.indigo800,
      );
  static get headlineLargeOnPrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get headlineMediumWhiteA700 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get headlineSmallWhiteA700 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.whiteA700,
      );
  // Label text style
  static get labelLargeLightgreen500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.lightGreen500,
        fontSize: 13.fSize,
      );
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 13.fSize,
      );
  static get labelMediumLightgreen500 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.lightGreen500,
      );
  static get labelSmallFFShamelFamilyWhiteA700 =>
      theme.textTheme.labelSmall!.fFShamelFamily.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelSmallLightgreen500 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.lightGreen500,
      );
  static get labelSmallLightgreen500_1 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.lightGreen500,
      );
  // Title text style
  static get titleLargeFFShamelFamilyLightgreen500 =>
      theme.textTheme.titleLarge!.fFShamelFamily.copyWith(
        color: appTheme.lightGreen500,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeWhiteA700 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumFFShamelFamilyWhiteA700 =>
      theme.textTheme.titleMedium!.fFShamelFamily.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17.fSize,
      );
  static get titleMediumLightgreen500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.lightGreen500,
      );
  static get titleMediumLightgreen700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.lightGreen700,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static get titleMediumRed700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.red700,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumWhiteA70017 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17.fSize,
      );
  static get titleSmallBahijTheSansArabic =>
      theme.textTheme.titleSmall!.bahijTheSansArabic;
  static get titleSmallBahijTheSansArabic15 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        fontSize: 15.fSize,
      );
  static get titleSmallBahijTheSansArabicGray400 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: appTheme.gray400,
      );
  static get titleSmallBahijTheSansArabicLightgreen500 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: appTheme.lightGreen500,
      );
  static get titleSmallBahijTheSansArabicOnPrimaryContainer =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 15.fSize,
      );
  static get titleSmallBahijTheSansArabicPrimary =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallBahijTheSansArabicPrimary_1 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallBahijTheSansArabicRed700 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: appTheme.red700,
      );
  static get titleSmallBahijTheSansArabicWhiteA700 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallBahijTheSansArabicWhiteA70015 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic.copyWith(
        color: appTheme.whiteA700,
        fontSize: 15.fSize,
      );
  static get titleSmallBahijTheSansArabic_1 =>
      theme.textTheme.titleSmall!.bahijTheSansArabic;
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
}

extension on TextStyle {

  TextStyle get bahijTheSansArabic {
    return copyWith(
      fontFamily: 'Bahij TheSansArabic',
    );
  }

  TextStyle get readexPro {
    return copyWith(
      fontFamily: 'Readex Pro',
    );
  }

  TextStyle get fFShamelFamily {
    return copyWith(
      fontFamily: 'FF Shamel Family',
    );
  }

  TextStyle get qatar2022Arabic {
    return copyWith(
      fontFamily: 'Qatar2022 Arabic',
    );
  }
}
