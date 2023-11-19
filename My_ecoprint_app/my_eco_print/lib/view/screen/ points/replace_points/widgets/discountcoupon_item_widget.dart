// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/%20points/collecting_points/collecting_points.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/resturant_screen.dart';


class ClothesScreen extends StatelessWidget {
  const ClothesScreen({Key? key}) : super(key: key);

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
          child: buildClothesContainer(context),
        ),
      ),
    );
  }

Widget buildClothesContainer(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;


   return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  width: 350.h,
                  height: 350.v,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Directionality(
                        textDirection: textDirection,
                        child: CustomImageView(
                          svgPath: ImageConstant.imgClose,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          onTap: () {
                            onTapImgCloseone(context);
                          },
                        ),
                      ),
                      Directionality(
                        textDirection: textDirection,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.h, top: 24.v),
                          child: Text(
                            "lbl48".tr,
                            style: CustomTextStyles.displaySmallRed700,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      SizedBox(
                        width: 300.h,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "msg49".tr,
                              style: theme.textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: "lbl_103".tr,
                              style: CustomTextStyles.titleMediumRed700,
                            ),
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Align(
  alignment: Alignment.center,
  child: CustomElevatedButton(
    height: 35.v,
    width: 150.h,
    text: "lbl49".tr,
    margin: EdgeInsets.only(top: 22.v),
    buttonStyle: CustomButtonStyles.fillLightGreenTL20,
    buttonTextStyle: CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
             contentPadding: EdgeInsets.zero,
                content: Container(
                  width: 350.h,
                  height: 350.v,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Directionality(
                        textDirection: textDirection,
                        child: CustomImageView(
                          svgPath: ImageConstant.imgClose,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          onTap: () {
                            onTapImgCloseone(context);
                          },
                        ),
                      ),
                    
                      SizedBox(height: 10.v),
                 Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 24.v, right: 59.h),
                  child: Text(
                    "lbl37".tr,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ),
              SizedBox(height: 46.v),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 156.h,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "lbl_104".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "lbl_50".tr,
                          style: CustomTextStyles.titleMediumLightgreen500,
                        ),
                             TextSpan(
                          text: "lbl_106".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                                           const WidgetSpan(
        child: SizedBox(width: 10.0),
      ),
              
                                TextSpan(
                          text: "lbl_105".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                                 
                         TextSpan(
                          text: "lbl_102".tr,
                          style: CustomTextStyles.titleMediumRed700,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
                     ] )));
        },
      );
    },
  ),
),

                    ],
                  ),
                ),
              );
            },
          );
        },
 child:  Center(
  child: Container(
    margin: EdgeInsets.only(top: 20.v),
    padding: EdgeInsets.symmetric(
      horizontal: 20.h,
      vertical: 5.v,
    ),
    decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
      borderRadius: BorderRadiusStyle.roundedBorder24,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.v,top: 10),
                    child: SizedBox(
                      height: 44.adaptSize,
                      width: 44.adaptSize,
                      child: Container(
                        height: 44.adaptSize,
                        width: 44.adaptSize,
                        padding: EdgeInsets.all(6.h),
                        decoration: AppDecoration.fillGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder17,
                        ),
                        child: CustomImageView(
                                svgPath: ImageConstant.imgMobileOnprimary,
                              
                          height: 44.adaptSize,
                          width: 44.adaptSize,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),

                
                  

                 
                   
                ],

             
              ),
                  
              
            ],
            
          ),
        ),
         Padding(padding:const EdgeInsets.symmetric(vertical: 10),
                     child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_102".tr,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                    
                  ), 
         Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                           "msg41".tr,
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: paint(textDirection: textDirection),
              ),
            ],
          ),
        ),
        
      ],
    ),
  ),
)



  );
}
}
class paint extends StatelessWidget {
  const paint({
    super.key,
    required this.textDirection,
  });

  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 47.v,
        width: 40.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: textDirection == TextDirection.rtl
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: SizedBox(
                height: 47,
                width: 40,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 50.v,
                    ),
                    child: CustomPaint(
                      painter: MyPainter(textDirection: textDirection),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "lbl_15002".tr,
                            style: CustomTextStyles.titleMediumWhiteA700,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: Text(
                              "lbl39".tr,
                              style: CustomTextStyles.titleMediumWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





