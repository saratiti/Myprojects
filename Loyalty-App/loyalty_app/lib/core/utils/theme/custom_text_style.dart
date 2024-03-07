import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumInterGray60001 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.gray60001,
        fontSize: 14.fSize,
      );
  static get bodyMediumMerriweatherBlack900 =>
      theme.textTheme.bodyMedium!.merriweather.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
      );
  static get bodyMediumMerriweatherBlack90001 =>
      theme.textTheme.bodyMedium!.merriweather.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
      );
  static get bodySmallInterGray800 => theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.gray800,
      );
  static get bodySmallInterff444444 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: Color(0XFF444444),
      );
  static get bodySmallMerriweatherWhiteA700 =>
      theme.textTheme.bodySmall!.merriweather.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallSFProTextGray300 =>
      theme.textTheme.bodySmall!.sFProText.copyWith(
        color: appTheme.gray300,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallSFProTextWhiteA700 =>
      theme.textTheme.bodySmall!.sFProText.copyWith(
        color: appTheme.whiteA700.withOpacity(0.8),
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallSFProTextWhiteA700Regular =>
      theme.textTheme.bodySmall!.sFProText.copyWith(
        color: appTheme.whiteA700.withOpacity(0.8),
        fontWeight: FontWeight.w400,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.8),
      );
  static get bodySmallWhiteA70010 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.8),
        fontSize: 10.fSize,
      );
  // Headline text style
  static get headlineSmallInterBlack900 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallInterBlack90001 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 25.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallInterDeeporange800 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.deepOrange800,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallInterGray800 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.gray800,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeBlack90001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeGray600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get labelLargeInterBlack900 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterBlack90001 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterBlack90001Medium =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterBlack900Medium =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterGray100 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.gray100,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterff967259 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: Color(0XFF967259),
        fontSize: 12.fSize,
      );
  static get labelLargeInterffd1512d =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: Color(0XFFD1512D),
        fontSize: 12.fSize,
      );
  static get labelLargeProximaNovaBluegray900 =>
      theme.textTheme.labelLarge!.proximaNova.copyWith(
        color: appTheme.blueGray900,
        fontSize: 12.fSize,
      );
  static get labelLargeProximaNovaDeeporange800 =>
      theme.textTheme.labelLarge!.proximaNova.copyWith(
        color: appTheme.deepOrange800,
        fontSize: 12.fSize,
      );
  static get labelLargeProximaNovaGray400 =>
      theme.textTheme.labelLarge!.proximaNova.copyWith(
        color: appTheme.gray400,
        fontSize: 12.fSize,
      );
  static get labelLargeSFProText =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeSFProTextGray60001 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appTheme.gray60001,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleMediumGray100 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray100,
        fontWeight: FontWeight.w900,
      );
  static get titleMediumInter => theme.textTheme.titleMedium!.inter.copyWith(
        fontSize: 16.fSize,
      );
  static get titleMediumInterBlack900 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterBlack90001 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterGray60001 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.gray60001,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPoppinsGray900 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSFProText =>
      theme.textTheme.titleMedium!.sFProText.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumSenBluegray90001 =>
      theme.textTheme.titleMedium!.sen.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 16.fSize,
      );
  static get titleSmallBluegray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90002,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallGray800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray800,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallSenBluegray90001 =>
      theme.textTheme.titleSmall!.sen.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w700,
      );
}

extension on TextStyle {
  TextStyle get merriweather {
    return copyWith(
      fontFamily: 'Merriweather',
    );
  }

  TextStyle get sourceSansPro {
    return copyWith(
      fontFamily: 'Source Sans Pro',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get proximaNova {
    return copyWith(
      fontFamily: 'Proxima Nova',
    );
  }

  TextStyle get sen {
    return copyWith(
      fontFamily: 'Sen',
    );
  }
}
