
import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';




class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
         mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child:Align(
      alignment: Alignment.center,
      child: 
      
      
      CustomImageView(
        imagePath: ImageConstant.imgRectangle28,
        height: 86.v,
        width: 170.h,
        radius: BorderRadius.circular(
          15.h,
        ),
      ),
   ) );
  }
}
