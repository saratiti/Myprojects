import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';

CustomAppBar buildAppBar(BuildContext context,String text) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return 

  
  
 CustomAppBar(

    height: 50.v,
    leadingWidth: 52.h,
    leading: CustomImageView(
              svgPath: (textDirection == TextDirection.rtl)
                  ? ImageConstant.imgArrowright
                  : ImageConstant.imgArrowleftOnprimary,
              height: 24.0,
              width: 24.0,
              margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              onTap: () => onTapArrowleft(context),
            ),
    centerTitle: true,
    title: AppbarTitle(text:text.tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
