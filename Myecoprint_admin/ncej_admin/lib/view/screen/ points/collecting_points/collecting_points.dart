
// ignore_for_file: overridden_fields, use_key_in_widget_constructors, unused_import
import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/view/screen/scan_code/generate_barcode_screen.dart';

class CollectingPointScreen extends StatelessWidget {
   const CollectingPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
    
   child: SafeArea(
      child: Scaffold(
        
        appBar:buildAppBar(context),
        body: 
        
        
        SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                   const SizedBox(height: 35,),
                  const RewardsList(),
                DividerWidget(text: "lbl34".tr,),
                 const SomeStackedWidgets(),
                  const ElevatedButton(),
                  const SomeOtherWidgets(),
                ],
              ),
            ),
          ),
        ),
  
      ),
    ));

  }
  
  void onTapArrowleft(BuildContext context) {

       
    Navigator.pop(context);
            


  }
  }




class RewardsList extends StatelessWidget {
  const RewardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPopDialog(context);
      }, 
      child:
      
       RawChip(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          "msg72".tr,
          style: TextStyle(
            color: appTheme.whiteA700,
            fontSize: 16.fSize,
            fontFamily: 'Bahij TheSansArabic',
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: CustomImageView(
          svgPath: ImageConstant.imgFile,
          height: 40.h,
          width: 40.h,
          margin: EdgeInsets.only(left: 5.h),
          color: Colors.white,
        ),
        onDeleted: () {},
        selected: false,
        backgroundColor: appTheme.lightGreen500,
        selectedColor: appTheme.lightGreen500,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

void _showPopDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.v),
          decoration: AppDecoration.fillWhiteA
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                svgPath: ImageConstant.imgClose,
                height: 24.adaptSize,
                width: 24.adaptSize,
                onTap: () {
                  onTapImgCloseone(context);
                },
              ),
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
                          text: "msg37".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "lbl_50".tr,
                          style: CustomTextStyles.titleMediumLightgreen500,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}}
 void onTapImgCloseone(BuildContext context) {
    Navigator.pop(context);
  }
class RewardCard extends StatelessWidget {
  final String labelText;
  final String subLabelText;

  const RewardCard({super.key, required this.labelText, required this.subLabelText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              subLabelText,
              textAlign: TextAlign.right,
              style: CustomTextStyles.bahijTheSansArabicOnPrimary,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text(
                labelText,
                textAlign: TextAlign.right,
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  @override
  final Key? key;
  final String text;

  const DividerWidget({ required this.text, this.key});

  @override
  Widget build(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,child: 
        Padding(
          padding: EdgeInsets.only(top: 20.v),
          child: Text(
            text,
            style: CustomTextStyles.headlineLargeOnPrimary,
          ),
        ),
      
    );
  }
}


class SomeStackedWidgets extends StatelessWidget {
  const SomeStackedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 264.v,
      width: 246.h,
      child: Stack(
      
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 193.v,
            width: 175.h,
            alignment: Alignment.center,
          ),
         
        ],
      ),
    );
  }
}

class ElevatedButton extends StatelessWidget {
  const ElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  const SizedBox(height: 20,),
   CustomElevatedButton(
  width: 236.h,
  text: "lbl35".tr,
  rightIcon: Container(
    margin: EdgeInsets.only(left: 22.h),
    child: CustomImageView(
      svgPath: ImageConstant.imgTicket,
    ),
  ),
  buttonStyle: CustomButtonStyles.fillLightGreen,
  onTap: () {
  
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  const BarcodeGenerator(),
      ),
    );
  },
)

  ],

    );
  }
}


class SomeOtherWidgets extends StatelessWidget {
  const SomeOtherWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35.h, top: 37.v, right: 28.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            svgPath: ImageConstant.imgArrowleft,
            height: 9.adaptSize,
            width: 9.adaptSize,
            margin: EdgeInsets.only(top: 8.v, bottom: 7.v),
          ),
     
        ],
      ),
    );
  }
}
CustomAppBar buildAppBar(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return 

  
  
 CustomAppBar(

    height: 50.v,
    leadingWidth: 52.h,
    leading: CustomImageView(
              svgPath: (textDirection == TextDirection.rtl)
                  ? ImageConstant.imgArrowright
                  : ImageConstant.imgArrowleftOnprimary,
              height: 24.0,
              width: 24.0,
              margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              onTap: () => onTapArrowleft(context),
            ),
    centerTitle: true,
    title: AppbarTitle(text:"lbl21".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
