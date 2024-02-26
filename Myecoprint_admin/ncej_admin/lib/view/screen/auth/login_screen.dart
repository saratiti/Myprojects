//ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ncej_admin/controller/auth_controller.dart';
import 'package:ncej_admin/controller/provider/company_provider.dart';
import 'package:ncej_admin/controller/text_controller.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/core/constants/theme/theme_helper.dart';
import 'package:ncej_admin/core/services/auth_service.dart';
import 'package:ncej_admin/data/module/login.dart';
import 'package:ncej_admin/view/screen/home_page/home_page_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textControllers = TextControllers();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCameraEnabled = false;
  bool isVisiblePassword = false;
  Color cameraButtonColor = appTheme.gray400;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  String savedPassword = "";

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
      isCameraEnabled = true;
    _loadSavedData(); 
  }
void _loadSavedData() async {
  String? savedEmail = await const FlutterSecureStorage().read(key: "saved_email");
  String? savedPassword = await const FlutterSecureStorage().read(key: "saved_password");

  print("Saved Email: $savedEmail");
  print("Saved Password: $savedPassword");

  if (savedEmail != null) {
    textControllers.emailController.text = savedEmail;
  }

  if (isCameraEnabled && savedPassword != null) {
    textControllers.passwordController.text = savedPassword;
  }
}



void _handleSignInAction(BuildContext context) async {
  EasyLoading.show(status: "Loading");

  String enteredEmail = textControllers.emailController.text;
  String enteredPassword = textControllers.passwordController.text;

  try {
    final Login? value = await AuthController().login(enteredEmail, enteredPassword);
    EasyLoading.dismiss();
    
    if (value != null) {
      await const FlutterSecureStorage().write(key: "token", value: "${value.accessToken}");
      Provider.of<CompanyProvider>(context, listen: false).setCompanyId(value.companyId); 

      if (isCameraEnabled) {
        await saveCredentials(enteredEmail, enteredPassword);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageScreen()),
      );
    } else {
      EasyLoading.showError("Invalid email or password");
    }
  } catch (ex) {
    EasyLoading.dismiss();

    if (ex is SocketException) {
      EasyLoading.showError("No internet connection");
    } else {
      EasyLoading.showError("Failed to sign in. Please try again.");
    }
  }
}



void toggleCamera() {
  setState(() {
    isCameraEnabled = !isCameraEnabled;
    cameraButtonColor = isCameraEnabled ? appTheme.lightGreen500 : appTheme.gray400;
  });

  if (isCameraEnabled && savedPassword.isEmpty) {
    savePassword();
  } else if (!isCameraEnabled) {
    savedPassword = "";
  }
}


void savePassword() async {
  String email = textControllers.emailController.text;
  String password = textControllers.passwordController.text; 
  savedPassword = password;

 
  if (isCameraEnabled) {
    await saveCredentials(email, password);
  }
}


 Future<void> saveCredentials(String email, String password) async {
  await const FlutterSecureStorage().write(key: "saved_email", value: email);
  await const FlutterSecureStorage().write(key: "saved_password", value: password);


  print('Saved Password: $password');
}


  void toggleIconEye() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return GestureDetector(
      onTap: () {
     _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child:
    
    
    SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: textDirection,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 92.v),
              child: SizedBox(
                height: 726.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _buildBackgroundImage(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildFingerprintImage(),
                            _buildMessageText(localization),
                            _buildEmailInputField(localization),
                            Directionality(
                              textDirection:
                                  localization.locale.languageCode == 'ar'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 22.v,
                                    right: 28.h,
                                  ),
                                  child: Text(
                                    "lbl2".tr,
                                    style: CustomTextStyles
                                        .titleSmallBahijTheSansArabicPrimary,
                                  ),
                                ),
                              ),
                            ),
                            _buildPasswordInputField(localization),
                            _buildResetPasswordAndCameraButtons(
                                context, localization),
                            _buildLoginButton(context),
                            SizedBox(
                              height: 15.h,
                            ),
                            _buildSignInButtons(),
                            _buildRegistrationLink(context, localization)
                          ],
                        ),
                      ),
                    ),
                    _buildLanguageSwitchButton(localization),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildBackgroundImage() {
    return Opacity(
      opacity: 0.1,
      child: CustomImageView(
        imagePath: ImageConstant.imgGroup70252,
        height: 702.v,
        width: 393.h,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildFingerprintImage() {
    return CustomImageView(
      svgPath: ImageConstant.imgFingerprintLightGreen500,
      height: 163.v,
      width: 289.h,
    );
  }

  Widget _buildMessageText(AppLocalizationController? localization) {
    return Directionality(
      textDirection: localization?.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 17.0, right: 28.0),
          child: Text(
            "msg2".tr,
            style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
          ),
        ),
      ),
    );
  }

Widget _buildEmailInputField(AppLocalizationController? localization) {
  return GestureDetector(
    onTap: () async {
      FocusScope.of(context).requestFocus(_emailFocusNode);

      if (isCameraEnabled) {
        String savedEmail = (await FlutterSecureStorage().read(key: "saved_email"))?.toString() ?? "";
        String savedPassword = (await FlutterSecureStorage().read(key: "saved_password"))?.toString() ?? "";

        if (savedPassword.isNotEmpty && textControllers.emailController.text == savedEmail) {
          textControllers.passwordController.text = savedPassword;

         
         
        }
      }
    },
    child: Directionality(
      textDirection: localization?.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: CustomTextFormField(
        focusNode: _emailFocusNode,
        controller: textControllers.emailController,
        margin: EdgeInsets.only(
          left: 7.h,
          top: 3.v,
          right: 8.h,
        ),
        hintText: "msg3".tr,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(10.h, 12.v, 20.h, 13.v),
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
    ),
  );
}







  Widget _buildPasswordInputField(AppLocalizationController? localization) {
  return GestureDetector(
    onTap: () async {
      FocusScope.of(context).requestFocus(_passwordFocusNode);

      if (isCameraEnabled) {
        String savedPassword = (await FlutterSecureStorage().read(key: "saved_password"))?.toString() ?? "";

        if (savedPassword.isNotEmpty) {
          textControllers.passwordController.text = savedPassword;
        }
      }
    },
    child: Directionality(
      textDirection: localization?.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: CustomTextFormField(
        focusNode: _passwordFocusNode,
        controller: textControllers.passwordController,
        margin: EdgeInsets.only(
          left: 7.h,
          top: 3.v,
          right: 8.h,
        ),
        hintText: "lbl2".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
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
        obscureText: !isVisiblePassword,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
          child: CustomImageView(
            svgPath: ImageConstant.imgLock,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 45.v,
        ),
        
      ),
    ),
  );
}



  Widget _buildResetPasswordAndCameraButtons(
      BuildContext context, AppLocalizationController? localization) {
    return Padding(
      padding: EdgeInsets.only(
        left: 11.h,
        top: 17.v,
        right: 11.h,
      ),
      child: Directionality(
        textDirection: localization?.locale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 4.v,
                bottom: 2.v,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.resetPassowrdEmail);
                },
                child: Text(
                  "msg5".tr,
                  style: CustomTextStyles.labelLargeLightgreen500,
                ),
              ),
            ),
            const Spacer(),
            CustomImageView(
              svgPath: ImageConstant.imgCamera,
              height: 24.adaptSize,
              width: 24.adaptSize,
              onTap: toggleCamera,
              color: cameraButtonColor,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 6.h,
                top: 10.v,
                bottom: 2.v,
              ),
              child: Text(
                "msg4".tr,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl3".tr,
      margin: const EdgeInsets.only(left: 26.0, top: 50.0, right: 27.0),
      onTap: () {
        if (_formKey.currentState!.validate()) {
          _handleSignInAction(context);
        }
      },
    );
  }

  Widget _buildSignInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SignInButton.mini(
          buttonType: ButtonType.google,
          onPressed: () async {
            AuthService().signInWithGoogle();
          },
        ),
        if (Platform.isIOS)
          SignInButton.mini(
            buttonType: ButtonType.apple,
            onPressed: () {},
          ),
      ],
    );
  }

  Widget _buildRegistrationLink(
      BuildContext context, AppLocalizationController? localization) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.h,
        top: 50.v,
      ),
      decoration: AppDecoration.outlineOnPrimaryContainer,
      child: Directionality(
        textDirection: localization?.locale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "msg6".tr,
              style: theme.textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.registerScreen);
              },
              child: Text(
                "lbl4".tr,
                style: CustomTextStyles.labelMediumLightgreen500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSwitchButton(AppLocalizationController? localization) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
      child: Align(
        alignment: Alignment.bottomLeft,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: localization?.locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            children: const [
              Icon(
                Icons.language,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
