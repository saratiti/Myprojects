import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';


class ListcoupontextItemWidget extends StatelessWidget {
  const ListcoupontextItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final localization = AppLocalizationController.to;

    final isRtl = localization.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.v),
          buildClothesContainer("msg30".tr, "lbl_540".tr, ImageConstant.imgMobile),
          SizedBox(height: 24.v),
          buildClothesContainer("msg31".tr, "lbl_60".tr, ImageConstant.imgFile),
          SizedBox(height: 24.v),
          buildClothesContainer("msg32".tr, "lbl_1500".tr, ImageConstant.imgFire),
        ],
      ),
    );
  }

  Widget buildClothesContainer(String message, String label, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
      margin: EdgeInsets.only(bottom: 24.v),
      decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: theme.textTheme.titleMedium),
                Text(label, style: CustomTextStyles.titleSmallBahijTheSansArabicRed700),
              ],
            ),
          ),
          CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            margin: EdgeInsets.only(top: 3.v),
            padding: EdgeInsets.all(11.h),
            child: CustomImageView(svgPath: iconPath),
          ),
        ],
      ),
    );
  }
}
