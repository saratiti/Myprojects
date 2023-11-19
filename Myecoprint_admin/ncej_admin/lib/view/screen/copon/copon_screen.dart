import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';

class CoponScreen extends StatelessWidget {
  const CoponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child:
    Scaffold(
      appBar: CustomAppBar(
        title: AppbarSubtitle(text: ''),
        actions: [
          AppbarImage(
            margin: EdgeInsets.fromLTRB(28.h, 21.v, 28.h, 22.v),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 4.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(context),
             SizedBox(height: 26.v),
             headerCoupon(),
            SizedBox(height: 26.v),
            buildCouponStack(),
          ],
        ),
      ),
    ));
  }

  Widget buildCouponStack() {
    return SizedBox(
      height: 715.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Opacity(
            opacity: 0.1,
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup70252,
              height: 702.v,
              width: 393.h,
              alignment: Alignment.center,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 31.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildCouponContainer("msg30".tr, "lbl_540".tr, ImageConstant.imgMobile),
                  SizedBox(height: 24.v),
                  buildCouponContainer("msg31".tr, "lbl_60".tr, ImageConstant.imgFile),
                  SizedBox(height: 24.v),
                  buildCouponContainer("msg32".tr, "lbl_1500".tr, ImageConstant.imgFire),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


Widget headerCoupon(){

return Align(
  alignment: Alignment.centerRight,
  child: Padding(
    padding: const EdgeInsets.only(top: 15, right: 32),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            "lbl24".tr,
            style: CustomTextStyles.titleSmallBahijTheSansArabic,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            "lbl25".tr,
            style: CustomTextStyles.titleSmallBahijTheSansArabicLightgreen500,
          ),
        ),
        CustomImageView(
          svgPath: ImageConstant.imgLocation,
          height: 24,
          width: 24,
          margin: const EdgeInsets.only(left: 26),
        ),
      ],
    ),
  ),
);

}

  Widget buildCouponContainer(String message, String label, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
      decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(message, style: theme.textTheme.titleMedium),
                Text(label, style: CustomTextStyles.titleSmallBahijTheSansArabicRed700),
              ],
            ),
          ),
          CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            margin: EdgeInsets.only( top: 1.v),
            padding: EdgeInsets.all(11.h),
            child: CustomImageView(svgPath: iconPath),
          ),
        ],
      ),
    );
  }
}

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

CustomAppBar buildAppBar(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return CustomAppBar(
    height: 40.v,
    leadingWidth: 52.h,
    leading: AppbarImage1(
      svgPath: (textDirection == TextDirection.rtl)
          ? ImageConstant.imgArrowright
          : ImageConstant.imgArrowleftOnprimary,
      margin: EdgeInsets.only(top: 5.v, bottom: 10),
      onTap: () {
        onTapArrowleft(context);
      },
    ),
    centerTitle: true,
    title: AppbarTitle(text:"lbl16".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
