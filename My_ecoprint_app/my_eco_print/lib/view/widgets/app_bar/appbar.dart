import 'dart:io';

import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

CustomAppBar buildAppBar(BuildContext context, String text) {
  final localization = AppLocalizationController.to;
  final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return CustomAppBar(
    height: 50.v,
    leadingWidth: 52.h,
    leading: CustomImageView(
      svgPath: (textDirection == TextDirection.rtl)
          ? ImageConstant.imgArrowright
          : ImageConstant.imgArrowleftOnprimary,
      height: 24.0,
      width: 24.0,
      margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      onTap: () => onTapArrowLeft(context),
    ),
    centerTitle: true,
    title: Directionality(
      textDirection: textDirection,
      child: AppbarTitle(text: text.tr),
    ),
  );
}

void onTapArrowLeft(BuildContext context) {

  if (Navigator.of(context).canPop()) {
  
    Navigator.of(context).pop();
  } else {
    
    Navigator.of(context).pop();
  }
}
