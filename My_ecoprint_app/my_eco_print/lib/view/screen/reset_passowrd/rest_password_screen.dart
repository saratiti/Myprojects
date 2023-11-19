// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class RestPasswordScreen extends StatelessWidget {
  RestPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController confirmpasswordController1 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
       
        body: Form(
          key: _formKey,
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
                              height: 754.v,
                              width: 393.h,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 59.h,
                                top: 162.v,
                                right: 59.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "msg22".tr,
                                    style: CustomTextStyles
                                        .titleLargeFFShamelFamilyLightgreen500,
                                  ),
                                  Container(
                                    width: 263.h,
                                    margin: EdgeInsets.only(
                                      left: 4.h,
                                      top: 10.v,
                                      right: 5.h,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "msg24".tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          TextSpan(
                                            text: "lbl_82".tr,
                                            style: CustomTextStyles
                                                .bodyMediumLightgreen500,
                                          ),
                                          const TextSpan(
                                            text: " ",
                                          ),
                                          TextSpan(
                                            text: "msg25".tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 32.v,
                                        right: 20.h,
                                      ),
                                      child: Text(
                                        "msg26".tr,
                                        style: CustomTextStyles
                                            .titleSmallBahijTheSansArabicGray400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 3.v),
                                  CustomTextFormField(
                                    controller: confirmpasswordController,
                                    hintText: "msg8".tr,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          17.h, 13.v, 30.h, 12.v),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.h,
                                        ),
                                      ),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgInfoGray400,
                                      ),
                                    ),
                                    prefixConstraints: BoxConstraints(
                                      maxHeight: 45.v,
                                    ),
                                    suffix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.h, 13.v, 20.h, 12.v),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.h,
                                        ),
                                      ),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgLockGray400,
                                      ),
                                    ),
                                    suffixConstraints: BoxConstraints(
                                      maxHeight: 45.v,
                                    ),
                                    obscureText: true,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 15.v,
                                        right: 20.h,
                                      ),
                                      child: Text(
                                        "msg27".tr,
                                        style: CustomTextStyles
                                            .titleSmallBahijTheSansArabicGray400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.v),
                                  CustomTextFormField(
                                    controller: confirmpasswordController1,
                                    hintText: "msg8".tr,
                                    textInputAction: TextInputAction.done,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          17.h, 13.v, 30.h, 12.v),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.h,
                                        ),
                                      ),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgInfoGray400,
                                      ),
                                    ),
                                    prefixConstraints: BoxConstraints(
                                      maxHeight: 45.v,
                                    ),
                                    suffix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.h, 13.v, 20.h, 12.v),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.h,
                                        ),
                                      ),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgLockGray400,
                                      ),
                                    ),
                                    suffixConstraints: BoxConstraints(
                                      maxHeight: 45.v,
                                    ),
                                    obscureText: true,
                                  ),
                                  CustomElevatedButton(
                                    text: "msg28".tr,
                                    margin: EdgeInsets.only(
                                      left: 18.h,
                                      top: 62.v,
                                      right: 20.h,
                                    ),
                                  ),
                                  SizedBox(height: 9.v),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "lbl3".tr,
                                        style: CustomTextStyles
                                            .labelMediumLightgreen500,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.h),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "msg17".tr,
                                                style:
                                                    theme.textTheme.labelMedium,
                                              ),
                                              const TextSpan(
                                                text: " ",
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
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
    ));
  }
}
