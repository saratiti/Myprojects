// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/%20points/refundable_item%D9%80points/widgets/discountcoupon1_item_widget.dart';

class RefundableItemPointScreen extends StatelessWidget {
  const RefundableItemPointScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: 117.v,
          leadingWidth: 66.h,
          leading: AppbarImage1(
            svgPath: ImageConstant.imgArrowleftOnprimary,
            margin: EdgeInsets.only(left: 42.h, top: 4.v, bottom: 4.v),
            onTap: () {
              onTapArrowleft(context);
            },
          ),
          title: AppbarTitle(
            text: "msg47".tr,
            margin: EdgeInsets.only(left: 25.h),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.h),
               
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 73.v, right: 32.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.v),
                        child: Text("lbl46".tr, style: CustomTextStyles.labelLargeOnPrimary),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 26.h, top: 1.v),
                        child: Text("lbl47".tr, style: CustomTextStyles.labelLargeLightgreen500),
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgLocation,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin: EdgeInsets.only(left: 26.h),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 26.v),
              SizedBox(
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
                        padding: EdgeInsets.only(left: 31.h, right: 31.h, bottom: 80.v),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 25.v);
                          },
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const DiscountcouponItemWidget();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: CustomFloatingButton(
          height: 56,
          width: 56,
          backgroundColor: appTheme.gray40001,
          child: CustomImageView(
            svgPath: ImageConstant.imgMobileOnprimary,
            height: 28.0.v,
            width: 28.0.h,
          ),
        ),
      ),
     ) );
  }
  void onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
