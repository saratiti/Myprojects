


import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'package:loyalty_app/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 1.h,
                  vertical: 3.v,
                ),
                child: Container(
                  width: 428.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder50,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 279.v,
                          width: 332.h,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse1279x314,
                                height: 279.v,
                                width: 314.h,
                                alignment: Alignment.centerRight,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 104.h,
                                    bottom: 51.v,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Login ",
                                        style: CustomTextStyles.titleMediumMulishffd1512d,
                                      ),
                                      SizedBox(height: 22.v),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 53.v),
                      _buildEmail(context),
                      SizedBox(height: 29.v),
                      _buildPassword(context),
                      SizedBox(height: 31.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 39.h),
                          child: Text(
                            "Forgot your password?",
                            style: CustomTextStyles.titleMediumMulishffd1512d,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.v),
                      _buildSignIn(context),
                      SizedBox(height: 30.v),
                      _buildCreateNewAccount(context),
                      SizedBox(height: 34.v),
                      Text(
                        "Or continue with",
                        style: CustomTextStyles.titleMediumMulishffd1512d,
                      ),
                      SizedBox(height: 20.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 44.v,
                            width: 60.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray200.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgPhGoogleLogoBold,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            height: 44.v,
                            width: 60.h,
                            margin: EdgeInsets.only(left: 10.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray200.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIcSharpFacebook,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            height: 44.v,
                            width: 60.h,
                            margin: EdgeInsets.only(left: 10.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray200.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIcBaselineApple,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.v),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
Widget _buildEmail(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      left: 32.h,
      right: 39.h,
    ),
    child: CustomTextFormField(
      controller: emailController,
      hintText: "Email",
      textInputType: TextInputType.emailAddress,
      prefix: Icon(Icons.email,color: Colors.grey,), 
    ),
  );
}

/// Section Widget
Widget _buildPassword(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      left: 32.h,
      right: 39.h,
    ),
    child: CustomTextFormField(
      controller: passwordController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: _obscureText, 
      prefix: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    ),
  );
}


  /// Section Widget
Widget _buildSignIn(BuildContext context) {
  return CustomElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, AppRoutes.homeScreen);
    },
    height: 60.v,
    text: "Sign in",
    margin: EdgeInsets.only(
      left: 32.h,
      right: 39.h,
    ),
    buttonStyle: CustomButtonStyles.outlineBlue,
    buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
  );
}

  /// Section Widget
  Widget _buildCreateNewAccount(BuildContext context) {
    return CustomElevatedButton(
      height: 41.v,
      text: "Create new account",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsGray800,
    );
  }
}
