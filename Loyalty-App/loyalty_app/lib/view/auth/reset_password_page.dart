// ignore_for_file: unnecessary_type_check, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/user.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'package:loyalty_app/widgets/custom_text_form_field.dart';

class ResetPassowrdEmailScreen extends StatelessWidget {
  ResetPassowrdEmailScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  Future<bool> checkIfEmailExists(String enteredEmail) async {
    try {
      final response = await UserController().sendPinForEmailVerification(enteredEmail);

      if (response is Map<String, dynamic>) {
      
        if (kDebugMode) {
          print('Response Body: $response');
        }

        final bool success = response['success'] ?? false;
        final bool exists = response['exists'] ?? false;

        if (success) {
          return exists; // Return the value of 'exists'
        } else {
          if (kDebugMode) {
            print('Failed to verify email existence: ${response['message']}');
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print('Unexpected response type: ${response.runtimeType}');
        }
        return false;
      }
    } catch (error) {
      // Handle errors, e.g., print an error message
      if (kDebugMode) {
        print('Error checking email existence: $error');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection =
        localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

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
                                      style: CustomTextStyles.titleMediumInter,
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
                                              style: CustomTextStyles.bodyMediumInterGray60001,
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
                                          style: CustomTextStyles.bodyMediumInterGray60001,
                                        ),
                                      ),
                                    ),
                                     Padding(
    padding: EdgeInsets.only(
      left: 32.h,
      right: 39.h,
    ),
    child:
                                    CustomTextFormField(
                                      controller: emailController,
                                   
                                      hintText: "msg3".tr,
                                      suffix: Container(
                                        margin: EdgeInsets.fromLTRB(10.h, 12.v, 20.h, 13.v),
                                        child: CustomImageView(
                                          
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
                                    )),
                                    GestureDetector(
                                      onTap: () async {
                                        String enteredEmail = emailController.text;

                                        if (enteredEmail.isEmpty) {
                                          // Show a dialog for empty email
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text("Email cannot be empty"),
                                                    CustomElevatedButton(
                                                      height: 62.v,
                                                      text: "OK",
                                                      margin: EdgeInsets.only(
                                                        top: 20.v,
                                                      ),
                                                      buttonStyle: CustomButtonStyles.fillPrimary,
                                                      // onTap: () {
                                                      //   Navigator.of(context).pop(); 
                                                      // },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                          return;
                                        }

                                        // Check if the email exists
                                        bool emailExists = await checkIfEmailExists(enteredEmail);

                                        if (emailExists) {
                                          // Handle the case when the email already exists.
                                          if (kDebugMode) {
                                            print("Email already exists!");
                                          }

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text("Your custom message for email exists..."),
                                                    CustomElevatedButton(
                                                      height: 62.v,
                                                      text: "msg18".tr,
                                                      margin: EdgeInsets.only(
                                                        top: 53.v,
                                                        right: 5.h,
                                                      ),
                                                      rightIcon: Container(
                                                        margin: const EdgeInsets.only(),
                                                        child: CustomImageView(
                                                        
                                                        ),
                                                      ),
                                                      // buttonStyle: CustomButtonStyles.outlineOnPrimaryContainer,
                                                      // buttonTextStyle: CustomTextStyles.labelSmallFFShamelFamilyWhiteA700,
                                                      // onTap: () {
                                                      //   Navigator.of(context).pop(); // Close the current dialog
                                                      //   // Reset the page by pushing the ResetPasswordEmailScreen again
                                                      //   Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) => ResetPassowrdEmailScreen(),
                                                      //     ),
                                                      //   );
                                                      // },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          // Proceed with your logic when the email doesn't exist.
                                          if (kDebugMode) {
                                            print("Email doesn't exist. Proceeding with your logic...");
                                          }

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text("Your custom message for email doesn't exist..."),
                                                    CustomElevatedButton(
                                                      height: 62.v,
                                                      text: "msg19_".tr,
                                                      margin: EdgeInsets.only(
                                                        top: 53.v,
                                                        right: 5.h,
                                                      ),
                                                      rightIcon: Container(
                                                        margin: const EdgeInsets.only(),
                                                        child: CustomImageView(
                                                          
                                                        ),
                                                      ),
                                                      // buttonStyle: CustomButtonStyles.outlineOnPrimaryContainer,
                                                      // buttonTextStyle: CustomTextStyles.labelSmallFFShamelFamilyWhiteA700,
                                                      // onTap: () {
                                                      //   Navigator.of(context).pop();
                                                      // },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: CustomElevatedButton(
                                        text: "lbl12".tr,
                                        margin: EdgeInsets.only(
                                          left: 30.h,
                                          top: 61.v,
                                          right: 31.h,
                                        ),
                                      ),
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
                                                  style: theme.textTheme.labelMedium,
                                                ),
                                                const TextSpan(
                                                  text: " ",
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                                          },
                                          child: Text(
                                            "lbl3".tr,
                                            style: CustomTextStyles.labelLargeGray600,
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
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
