import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';

class PinCodePasswordScreen extends StatelessWidget {
  const PinCodePasswordScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
   final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 92.v),
            child: SizedBox(
              height: 878.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 854.v,
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
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 46.h,
                                top: 162.v,
                                right: 46.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "msg12".tr,
                                    style: CustomTextStyles
                                        .titleLargeFFShamelFamilyLightgreen500,
                                  ),
                                  Container(
                                    width: 252.h,
                                    margin: EdgeInsets.only(
                                      left: 23.h,
                                      top: 14.v,
                                      right: 24.h,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "msg20".tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          TextSpan(
                                            text: "lbl_62".tr,
                                            style: CustomTextStyles
                                                .bodyMediumLightgreen500,
                                          ),
                                          TextSpan(
                                            text: "lbl13".tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  CustomPinCodeTextField(
                                    context: context,
                                    margin: EdgeInsets.only(
                                      top: 41.v,
                                      right: 1.h,
                                    ),
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(height: 10.v),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgClock,
                                        height: 13.v,
                                        width: 11.h,
                                        margin: EdgeInsets.only(bottom: 2.v),
                                      ),
                                      Text(
                                        "lbl_00_59".tr,
                                        style:
                                            CustomTextStyles.bodySmallReadexPro,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "msg21".tr,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    svgPath: ImageConstant.imgFingerprintLightGreen500,
                    height: 163.v,
                    width: 289.h,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
     ) );
  }
}

