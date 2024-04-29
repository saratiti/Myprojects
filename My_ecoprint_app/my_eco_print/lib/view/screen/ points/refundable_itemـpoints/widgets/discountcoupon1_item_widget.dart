
import 'package:my_eco_print/core/app_export.dart';

class DiscountcouponItemWidget extends StatelessWidget {
  const DiscountcouponItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 107.v,
        width: 330.h,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 15.v,
                ),
                decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 60.v,
                      width: 171.h,
                      margin: EdgeInsets.only(bottom: 1.v),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "msg41".tr,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "lbl_102".tr,
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 56.adaptSize,
                      width: 56.adaptSize,
                      padding: EdgeInsets.all(6.h),
                      decoration: AppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder17,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgImage1305,
                        height: 44.adaptSize,
                        width: 44.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 47.v,
                width: 40.h,
                margin: EdgeInsets.only(left: 36.h),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgBookmark,
                      height: 47.v,
                      width: 40.h,
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 3.h,
                          top: 4.v,
                          right: 4.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lbl_15002".tr,
                              style: CustomTextStyles.titleMediumWhiteA700,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                "lbl39".tr,
                                style: CustomTextStyles.bahijTheSansArabicWhiteA700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 107.v,
                width: 330.h,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.v),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                          vertical: 15.v,
                        ),
                        decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "msg46".tr,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "lbl_102".tr,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                            CustomIconButton(
                              height: 56.adaptSize,
                              width: 56.adaptSize,
                              margin: EdgeInsets.only(left: 15.h),
                              padding: EdgeInsets.all(11.h),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgMobileOnprimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 47.v,
                        width: 40.h,
                        margin: EdgeInsets.only(left: 36.h),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgBookmark,
                              height: 47.v,
                              width: 40.h,
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 3.h,
                                  top: 4.v,
                                  right: 4.h,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "lbl_15002".tr,
                                      style: CustomTextStyles.titleMediumWhiteA700,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.h),
                                      child: Text(
                                        "lbl39".tr,
                                        style: CustomTextStyles.bahijTheSansArabicWhiteA700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     ) );
  }
}
