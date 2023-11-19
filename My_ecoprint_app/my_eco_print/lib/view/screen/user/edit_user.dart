
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  TextEditingController personalnameController = TextEditingController();

  TextEditingController emailaddressController = TextEditingController();

  TextEditingController phonenumberoneController = TextEditingController();

  TextEditingController passwordplacehoController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCheckmarkVisible = false;

  void toggleCheckmark() {
    setState(() {
      isCheckmarkVisible = !isCheckmarkVisible;
    });
  }  
  bool isVisiblePassword = false;
  bool isVisiblePassword2 = false;


  void toggleIconEye() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    
    });
  }

    void toggleIVisibleEye() {
    setState(() {
     
      isVisiblePassword2=!isVisiblePassword2;
    });
  }
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection =
        localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
    mediaQueryData = MediaQuery.of(context);
 
return Directionality(
    textDirection: textDirection,
    child: Scaffold(
      appBar: buildAppBar(context),
        body: Directionality(
          textDirection: textDirection,
       child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 43.v),
            child: SizedBox(
              height: 927.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgGroup70252,
                      height: 854.v,
                      width: 393.h,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 52.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgFingerprintLightGreen500,
                            height: 163.v,
                            width: 289.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 17.v,
                                right: 28.h,
                              ),
                              child: Text(
                                "lbl5".tr,
                                style: CustomTextStyles
                                    .titleSmallBahijTheSansArabicGray400,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            controller: personalnameController,
                            margin: EdgeInsets.only(
                              left: 7.h,
                              top: 3.v,
                              right: 8.h,
                            ),
                            hintText: "msg7".tr,
                            suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.h,
                                ),
                              ),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgUser,
                              ),
                            ),
                            suffixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 30.h,
                              top: 11.v,
                              bottom: 11.v,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 22.v,
                                right: 28.h,
                              ),
                              child: Text(
                                "msg2".tr,
                                style: CustomTextStyles
                                    .titleSmallBahijTheSansArabicPrimary,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            controller: emailaddressController,
                            margin: EdgeInsets.only(
                              left: 7.h,
                              top: 3.v,
                              right: 8.h,
                            ),
                            hintText: "msg3".tr,
                            suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.h, 12.v, 20.h, 13.v),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgCheckmark,
                              ),
                            ),
                            suffixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 30.h,
                              top: 11.v,
                              bottom: 11.v,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 22.v,
                                right: 28.h,
                              ),
                              child: Text(
                                "lbl6".tr,
                                style: CustomTextStyles
                                    .titleSmallBahijTheSansArabicGray400,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            controller: phonenumberoneController,
                            margin: EdgeInsets.only(
                              left: 7.h,
                              top: 3.v,
                              right: 8.h,
                            ),
                            hintText: "lbl6".tr,
                            suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.h,
                                ),
                              ),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgCall,
                              ),
                            ),
                            suffixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 30.h,
                              top: 11.v,
                              bottom: 11.v,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 22.v,
                                right: 28.h,
                              ),
                              child: Text(
                                "lblـ28".tr,
                                style: CustomTextStyles
                                    .titleSmallBahijTheSansArabicPrimary,
                              ),
                            ),
                          ),
                           CustomTextFormField(
                            controller: passwordplacehoController,
                            margin: EdgeInsets.only(
                              left: 7.h,
                              top: 3.v,
                              right: 8.h,
                            ),
                            hintText: "lblـ28".tr,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            prefix: GestureDetector(
                              onTap: toggleIconEye,
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                child: Icon(
                                  isVisiblePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            prefixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                            obscureText: !isVisiblePassword,
                            suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgLock,
                              ),
                            ),
                           ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 20.v,
                                right: 28.h,
                              ),
                              child: Text(
                                "lblـ29".tr,
                                style: CustomTextStyles
                                    .titleSmallBahijTheSansArabicPrimary,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            controller: confirmpasswordController,
                            margin: EdgeInsets.only(
                              left: 7.h,
                              top: 3.v,
                              right: 8.h,
                            ),
                            hintText: "lblـ29".tr,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            prefix: GestureDetector(
                              onTap: toggleIVisibleEye,
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                child: Icon(
                                  isVisiblePassword2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            prefixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                            obscureText: !isVisiblePassword2,
                            suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgLock,
                              ),
                            ),
                            suffixConstraints: BoxConstraints(
                              maxHeight: 45.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 27.h,
                              top: 17.v,
                              right: 13.h,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              
                              
                        ]),

                          ),
                              
                          CustomElevatedButton(
                            text: "lblـ27".tr,
                            margin: EdgeInsets.only(
                              left: 26.h,
                              top: 56.v,
                              right: 27.h,
                            ),
                          ),
                          SizedBox(height: 9.v),

                          
            CustomElevatedButton(
  text: "lbl30_".tr,
  margin: EdgeInsets.only(
    left: 26.h,
    top: 56.v,
    right: 27.h,
  ),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("?Are you sure you want to delete your account"),
          actions: [
            TextButton(
              onPressed: () {
    
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  },
  buttonStyle: CustomButtonStyles.fillRed, // Set the button color to red

)

                        ],
                      ),
                    ),
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


CustomAppBar buildAppBar(BuildContext context) {
  final localization = AppLocalizationController.to;
  final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return CustomAppBar(
    height: 90.v,
    leadingWidth: 52.h,
    leading: AppbarImage1(
      svgPath: (textDirection == TextDirection.rtl)
          ? ImageConstant.imgArrowright
          : ImageConstant.imgArrowleftOnprimary,
      margin: EdgeInsets.only(top: 5.v, bottom: 5),
      onTap: () {
        onTapArrowleft(context);
      },
    ),
    centerTitle: true,
    title: AppbarTitle(text:"msg34".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
