// ignore_for_file: must_be_immutable, library_private_types_in_public_api




import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:loyalty_app/view/auth/login_page.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController confirmpasswordController1 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isVisiblePassword = false; // Moved isVisiblePassword to be a member variable
bool isVisiblePassword1 = false;
  @override
  Widget build(BuildContext context) {
    final Object? routeArguments = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? arguments = routeArguments is Map<String, dynamic> ? routeArguments : null;

    void toggleIconEye() {
      setState(() {
        isVisiblePassword = !isVisiblePassword;
      });
    }
   void toggleIconEye1() {
      setState(() {
        isVisiblePassword1 = !isVisiblePassword1;
      });
    }
    if (arguments == null) {
      return const Scaffold(
        body: Center(
          child: Text('Invalid route arguments'),
        ),
      );
    }

    final String userEmail = arguments['email'] ?? '';

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
                              // child: CustomImageView(
                              //   imagePath: ImageConstant.imgGroup70252,
                              //   height: 754.v,
                              //   width: 393.h,
                              //   alignment: Alignment.topCenter,
                              // ),
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
                                      "msg22".localized,
                                      style: CustomTextStyles.titleMediumInterGray60001,
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
                                              text: "msg24".localized,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            TextSpan(
                                              text: "lbl_82".localized,
                                              style: CustomTextStyles.titleMediumPoppinsGray700,
                                            ),
                                            const TextSpan(
                                              text: " ",
                                            ),
                                            TextSpan(
                                              text: "msg25".localized,
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
                                          "msg26".localized,
                                          style: CustomTextStyles.titleSmallPoppinsGray800,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.v),
                                    CustomTextFormField(
                                      controller: confirmpasswordController,
                                     
                                      hintText: "lbl2".localized,
                                      textInputAction: TextInputAction.done,
                                      textInputType: TextInputType.visiblePassword,
                                      obscureText: !isVisiblePassword,
                                      prefix: GestureDetector(
                                        onTap: toggleIconEye,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                          child: Icon(
                                            isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      prefixConstraints: BoxConstraints(
                                        maxHeight: 45.v,
                                      ),
                                      suffix: Container(
                                        margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                        // child: CustomImageView(
                                        //   svgPath: ImageConstant.imgLock,
                                        // ),
                                      ),
                                      suffixConstraints: BoxConstraints(
                                        maxHeight: 45.v,
                                      ),
                                    
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 15.v,
                                          right: 20.h,
                                        ),
                                        child: Text(
                                          "msg27".localized,
                                          style: CustomTextStyles.titleMediumPoppinsGray900,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.v),
                                    CustomTextFormField(
                                      controller: confirmpasswordController1,
                                      hintText: "msg8".localized,
                                      textInputAction: TextInputAction.done,
                                      textInputType: TextInputType.visiblePassword,
                                      obscureText: !isVisiblePassword1, 
                                      prefix: GestureDetector(
                                        onTap: toggleIconEye1,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                          child: Icon(
                                            isVisiblePassword1 ? Icons.visibility : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      prefixConstraints: BoxConstraints(
                                        maxHeight: 45.v,
                                      ),
                                      suffix: Container(
                                        margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
                                        // child: CustomImageView(
                                        //   svgPath: ImageConstant.imgLock,
                                        // ),
                                      ),
                                      suffixConstraints: BoxConstraints(
                                        maxHeight: 45.v,
                                      ),
                                     
                                    ),
                                    CustomElevatedButton(
                                      text: "msg28".localized,
                                      margin: EdgeInsets.only(
                                        left: 18.h,
                                        top: 62.v,
                                        right: 20.h,
                                      ),
                                      onPressed: () {
                                        String email = userEmail;
                                        String currentPassword = confirmpasswordController.text;
                                        String newPassword = confirmpasswordController1.text;

                                        UserController().changePassword(
                                          email,
                                          currentPassword,
                                          newPassword,
                                        ).then((success) {
                                          if (success) {
                                         
                                           
                                                Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                                           
                                          } else {
                                           
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Password change failed"),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(height: 9.v),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "lbl3".localized,
                                          style: CustomTextStyles.labelLargeBlack90001,
                                        ),
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
