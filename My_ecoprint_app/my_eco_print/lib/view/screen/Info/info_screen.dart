import 'package:flutter/material.dart';
import 'package:my_eco_print/core/utils/image_constant.dart';
import 'package:my_eco_print/core/localization/app_localization.dart';
import 'package:my_eco_print/core/constants/theme/theme_helper.dart';
import 'package:my_eco_print/view/widgets/custom_image_view.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              // Background Image
              Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.imgGroup12,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50, 
                left: 169, 
                child: Text(
                  "lbl54".tr,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Positioned(
                top: 155, 
                left: 52, 
                child: CustomImageView(
                  svgPath: ImageConstant.imgFingerprintLightGreen500,
                  width: 289,
                  height: 163,
                  alignment: Alignment.topCenter,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

