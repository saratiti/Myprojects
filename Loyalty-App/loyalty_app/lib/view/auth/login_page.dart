// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:io';

import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  void _handleSignInAction(BuildContext context) async {
    EasyLoading.show(status: "Loading");

    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    AuthController()
        .login(enteredEmail, enteredPassword)
        .then((Login? value) async {
      EasyLoading.dismiss();
      await const FlutterSecureStorage().write(
          key: "token", value: "${value!.accessToken}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }).catchError((ex) {
      EasyLoading.dismiss();

      if (ex is SocketException) {
        EasyLoading.showError("No internet connection");
      } else {
        String errorMessage = ex.toString();
        if (errorMessage.contains("Invalid email or password")) {
          errorMessage = "Invalid email or password";
        } else {
          errorMessage = "Invalid email or password. Please try again.";
        }
        EasyLoading.showError(errorMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child: SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _loginFormKey,
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
  alignment: localization.locale.languageCode == 'ar'
      ? Alignment.centerRight 
      : Alignment.centerLeft,
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassowrdEmailScreen(),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(
      
        right: localization.locale.languageCode == 'en' ? 40.h : 20.h,
        left: localization.locale.languageCode == 'ar' ? 40.h : 20.h,
      ),
      child: Text(
        "msg5".localized,
        style: CustomTextStyles.titleMediumMulishffd1512d,
        textDirection: TextDirection.ltr, 
      ),
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
                       _buildLanguageSwitchButton(localization),
                    ],
                  ),
                ),
               
              ),
            ),
          ),
        ),
      ),
  ));
  }


  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      child: CustomTextFormField(
        controller: emailController,
         focusNode: _emailFocusNode,
        hintText:"msg2".localized,
        textInputType: TextInputType.emailAddress,
        prefix: const Icon(Icons.email,color: Colors.grey,), 
        cursorColor:appTheme.deepOrange800
      ),
    );
  }

 
  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      child: CustomTextFormField(
        controller: passwordController,
         focusNode: _passwordFocusNode,
        hintText: "lbl2".localized,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: _obscureText, 
        cursorColor:appTheme.deepOrange800,
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

  Widget _buildSignIn(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        _handleSignInAction(context);
      },
      height: 60.v,
      text: "lbl3".localized,
      margin: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      buttonStyle: CustomButtonStyles.outlineBlue,
      buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
    );
  }

  Widget _buildCreateNewAccount(BuildContext context) {
    return CustomElevatedButton(
      height: 41.v,
      text: "lbl4".localized,
      margin: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsGray800,
      onPressed: () {
      
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
    );
  }
Widget _buildLanguageSwitchButton(AppLocalizationController? localization) {
    final textDirection = localization!.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
    child:Padding(
    padding: const EdgeInsets.only( bottom: 20, left: 15),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            final localization = AppLocalizationController.to;
            if (localization.locale.languageCode == 'en') {
              localization.locale = const Locale('ar');
            } else {
              localization.locale = const Locale('en');
            }
            setState(() {});
          },
          backgroundColor: appTheme.deepOrange800, // Set background color
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: localization?.locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            children:  [
              Icon(
                Icons.language,
                color: appTheme.whiteA700,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    ),
   ) );
}

}
