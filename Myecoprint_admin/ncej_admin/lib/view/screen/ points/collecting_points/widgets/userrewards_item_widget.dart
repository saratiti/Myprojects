import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';

// ignore: must_be_immutable
class UserrewardsItemWidget extends StatelessWidget {
  const UserrewardsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child:
    
    Container(
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
          Padding(
            padding: EdgeInsets.only(
              top: 7.v,
              bottom: 4.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "msg35".tr,
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "lbl_50".tr,
                  style: CustomTextStyles
                      .titleSmallBahijTheSansArabicLightgreen500,
                ),
              ],
            ),
          ),
          CustomIconButton(
            height: 56.adaptSize,
            width: 56.adaptSize,
            margin: EdgeInsets.only(
              left: 16.h,
              top: 1.v,
            ),
            padding: EdgeInsets.all(15.h),
            child: CustomImageView(
              svgPath: ImageConstant.imgTicketLightGreen500,
            ),
          ),
        ],
      ),
    ));
  }
}
