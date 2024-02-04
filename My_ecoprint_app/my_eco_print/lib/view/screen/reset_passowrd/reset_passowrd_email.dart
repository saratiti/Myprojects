// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';

class ResetPassowrdEmailScreen extends StatelessWidget {
 ResetPassowrdEmailScreen({Key? key})
      : super(
          key: key,
        );

  final TextEditingController emailController = TextEditingController();
bool emailExists = false; 
 Future<bool> checkIfEmailExists(String enteredEmail) async {
    // Call the UserController's exitEmail method
    bool exists = await UserController().exitEmail(enteredEmail);

    // Update the emailExists variable based on the result
    emailExists = exists;

    // Return the result
    return exists;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: SafeArea(
      child: Scaffold(

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
                                left: 47.h,
                                top: 162.v,
                                right: 47.h,
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
                                    width: 274.h,
                                    margin: EdgeInsets.only(
                                      left: 8.h,
                                      top: 14.v,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "msg14".tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          TextSpan(
                                            text: "msg15".tr,
                                            style: CustomTextStyles
                                                .bodyMediumLightgreen500,
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
                                        top: 22.v,
                                        right: 32.h,
                                      ),
                                      child: Text(
                                        "msg2".tr,
                                        style: CustomTextStyles
                                            .titleSmallBahijTheSansArabicPrimary,
                                      ),
                                    ),
                                  ),
                                CustomTextFormField(
                            controller: emailController,
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
                                  CustomElevatedButton(
                                    text: "lbl12".tr,
                                    margin: EdgeInsets.only(
                                      left: 30.h,
                                      top: 61.v,
                                      right: 31.h,
                                      
                                    ),   onTap: () async {
  String enteredEmail = emailController.text;

  // Check if the email exists
  bool emailExists = await checkIfEmailExists(enteredEmail);

  if (emailExists) {
    // Handle the case when the email already exists.
    print("Email already exists!");
    
    
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Your custom message for email exists..."),
          CustomElevatedButton(
            height: 62.v,
            text: "msg18".tr,
            margin: EdgeInsets.only(
              top: 53.v,
              right: 5.h,
            ),
            rightIcon: Container(
              margin: EdgeInsets.only(),
              child: CustomImageView(
                svgPath: ImageConstant.imgGroup48096390,
              ),
            ),
            buttonStyle: CustomButtonStyles.outlineOnPrimaryContainer,
            buttonTextStyle: CustomTextStyles.labelSmallFFShamelFamilyWhiteA700,
            onTap: () {
              Navigator.of(context).pop(); // Close the current dialog
              Navigator.of(context).pushNamed(AppRoutes.pinCodePassword); // Navigate to PinCodePasswordScreen
            },
          ),
        ],
      ),
    );
  },
);

  } else {
    // Proceed with your logic when the email doesn't exist.
    print("Email doesn't exist. Proceeding with your logic...");

 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Your custom message for email doesn't exist..."),
              CustomElevatedButton(
                height: 62.v,
                text: "msg19_".tr,
                margin: EdgeInsets.only(
                  top: 53.v,
                  right: 5.h,
                ),
                rightIcon: Container(
                  margin: EdgeInsets.only(),
                  child: CustomImageView(
                    svgPath: ImageConstant.imgGroup48096390,
                  ),
                ),
                buttonStyle: CustomButtonStyles.outlineOnPrimaryContainer,
                buttonTextStyle: CustomTextStyles.labelSmallFFShamelFamilyWhiteA700,
                onTap: () {
                  Navigator.of(context).pop(); 
                  
                },
              ),
            ],
          ),
        );
      },
    );
  }
},

                                    buttonStyle:
                                        CustomButtonStyles.fillLightGreen,
                                  ),
                                  SizedBox(height: 25.v),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     
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
                                       Text(
                                        "lbl3".tr,
                                        style: CustomTextStyles
                                            .labelMediumLightgreen500,
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
