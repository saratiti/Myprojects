// ignore_for_file: unnecessary_type_check, use_build_context_synchronously
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class ResetPassowrdEmailScreen extends StatelessWidget {
  ResetPassowrdEmailScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  Future<bool> checkIfEmailExists(String enteredEmail) async {
    try {
      final response = await UserController().sendPinForEmailVerification(enteredEmail);

      if (response is Map<String, dynamic>) {
        if (kDebugMode) {
          print('Response Body: $response');
        }

        final bool success = response['success'] ?? false;
        final bool exists = response['exists'] ?? false;

        return success ? exists : false;
      } else {
        if (kDebugMode) {
          print('Unexpected response type: ${response.runtimeType}');
        }
        return false;
      }
    } catch (error) {
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
                                child: Form(
                                  key: _formKey, 
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "msg12".localized,
                                        style: CustomTextStyles.titleLargeWhiteA700,
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
                                                text: "msg14".localized,
                                                style: theme.textTheme.bodyMedium,
                                              ),
                                              TextSpan(
                                                text: "msg15".localized,
                                                style: CustomTextStyles.bodySmallGray400,
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
                                            "msg2".localized,
                                            style: CustomTextStyles.bodySmallDeeporange800,
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        controller: emailController,
                                      cursorColor:appTheme.deepOrange800,
                                        hintText: "msg3".localized,
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Email cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      CustomElevatedButton(
                                        text: "lbl12".localized,
                                        margin: EdgeInsets.only(
                                          left: 30.h,
                                          top: 61.v,
                                          right: 31.h,
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState?.validate() ?? false) {
                                            String enteredEmail = emailController.text;

                                            bool emailExists = await checkIfEmailExists(enteredEmail);

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        emailExists
                                                            ? "Your custom message for email exists..."
                                                            : "Your custom message for email doesn't exist...",
                                                      ),
                                                      CustomElevatedButton(
                                                        height: 62.v,
                                                        text: emailExists ? "msg18".localized : "msg19_".localized,
                                                        margin: EdgeInsets.only(
                                                          top: 53.v,
                                                          right: 5.h,
                                                        ),
                                                        rightIcon: Container(
                                                          margin: const EdgeInsets.only(),
                                                          child: CustomImageView(
                                                           
                                                          ),
                                                        ),
                                                        buttonStyle: CustomButtonStyles.outlineBlueTL27,
                                                        buttonTextStyle: CustomTextStyles.labelLargeInterBlack900,
                                                        onPressed: () {
                                                          Navigator.of(context).pop(); 
                                                          if (emailExists) {
                                                            Navigator.of(context).pushNamed(AppRoutes.pinCodePassword, arguments: {'email': enteredEmail});
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
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
                                                    text: "msg17".localized,
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
                                              "lbl3".localized,
                                              style: CustomTextStyles.labelLargeInterBlack900Medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
