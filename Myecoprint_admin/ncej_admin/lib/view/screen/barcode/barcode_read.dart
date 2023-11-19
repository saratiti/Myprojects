

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/view/screen/barcode/widgets/discountcoupon_item_widget.dart';

class ScanCodeScreen extends StatelessWidget {
 ScanCodeScreen({Key? key}) : super(key: key);
String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String formattedCurrentTime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: buildCustomAppBar(context),
          body: buildBody(mediaQueryData),
        ),
      ),
    );
  }

  CustomAppBar buildCustomAppBar(BuildContext context) {
    return CustomAppBar(
      height: 117.v,
      leadingWidth: 66.h,
      leading: AppbarImage1(
        svgPath: ImageConstant.imgArrowleftOnprimary,
        margin: EdgeInsets.only(left: 42.h, top: 4.v, bottom: 4.v),
        onTap: () => onTapArrowleft(context),
      ),
      title: AppbarTitle(
        text: "msg50".tr,
        margin: EdgeInsets.only(left: 47.h),
      ),
    );
  }

  Widget buildBody(MediaQueryData mediaQueryData) {
    return SizedBox(
      width: mediaQueryData.size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
         
            const ReplacePointListClothes(),
            buildStackWithAlignment(),
            
          ],
        ),
      ),
    );
  }

Stack buildStackWithAlignment() {
  return Stack(
    
    alignment: Alignment.topRight,
    children: [
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 700.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Opacity(
                opacity: 0.1,
                child: CustomImageView(
                  imagePath: ImageConstant.imgGroup70252,
                  height: 600.v,
                  width: 393.h,
                  alignment: Alignment.topCenter,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only( right: 18.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("msg51".tr,
                          style: CustomTextStyles.titleSmallBahijTheSansArabic15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.h, top: 7.v),
                        child: Row(
                          children: [
                            Text(
  formattedCurrentTime,
  style: CustomTextStyles.titleSmallBahijTheSansArabic,
),
                            CustomImageView(
                              svgPath: ImageConstant.imgClockLightGreen500,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.only(left: 13.h),
                            ),
                                              Padding(
  padding: EdgeInsets.only(left: 55.h, top: 8.v),
  child: Text(
    formattedCurrentDate,
    style: CustomTextStyles.titleMediumOnPrimaryContainer,
  ),
),
                            CustomImageView(
                              svgPath: ImageConstant.imgCalendar,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.only(left: 13.h),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 44.v,
                        width: 216.h,
                        margin: EdgeInsets.only(left: 100.h, top: 32.v),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text("lbl50".tr,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("msg52".tr,
                                style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgQrcodeformob,
                        height: 195.adaptSize,
                        width: 195.adaptSize,
                        margin: EdgeInsets.only(left: 100.h, top: 21.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 140.h, top: 8.v),
                        child: Text("lbl_0221555a0bb2".tr,
                          style: CustomTextStyles.titleMediumOnPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Padding( padding: EdgeInsets.only(left: 100.h, top: 27.v),
                      child: SizedBox(
                        width: 222.h,
                        child: Text("msg53".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleSmallBahijTheSansArabic_1,
                        ),
                      ),),
                      
                      Padding(
                        padding: EdgeInsets.only(left: 180.h, top: 27.v),
                        child: Text("lbl51".tr,
                          style: CustomTextStyles.titleSmallBahijTheSansArabic15,
                        ),
                      ),
                      CustomElevatedButton(
                        height: 32.v,
                        width: 190.h,
                        text: "msg54".tr,
                        margin: EdgeInsets.only(left: 100.h, top: 6.v),
                        buttonStyle: CustomButtonStyles.fillLightGreenTL161,
                        buttonTextStyle: theme.textTheme.labelLarge,
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
  );
}

}

class ReplacePointListClothes extends StatelessWidget {
  const ReplacePointListClothes({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.v),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20.v);
                },
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const ClothesScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
