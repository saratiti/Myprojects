// // ignore_for_file: must_be_immutable, library_private_types_in_public_api

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/text_controller.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCheckmarkVisible = false;
  bool isVisiblePassword = false;
  bool isVisiblePassword2 = false;
  final textControllers = TextControllers();

  void toggleCheckmark() {
    setState(() {
      isCheckmarkVisible = !isCheckmarkVisible;
    });
  }

  void toggleIconEye() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  void toggleIVisibleEye() {
    setState(() {
      isVisiblePassword2 = !isVisiblePassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: textDirection,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 43.v),
              child: buildRegisterForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    return SizedBox(
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
                  buildFingerprintImage(),
                  buildTextFormField(
                    controller: textControllers.personalnameController,
                    hintText: "msg7".tr,
                    suffix: buildUserIcon(),
                  ),
                  buildTextFormField(
                    controller: textControllers.emailaddressController,
                    hintText: "msg3".tr,
                    suffix: buildCheckmarkIcon(),
                  ),
                  buildTextFormField(
                    controller: textControllers.phonenumberoneController,
                    hintText: "lbl6".tr,
                    suffix: buildCallIcon(),
                  ),
                  buildTextFormField(
                    controller: textControllers.passwordplacehoController,
                    hintText: "lbl2".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    prefix: buildVisibilityIcon(toggleIconEye, isVisiblePassword),
                    suffix: buildLockIcon(),
                  ),
                  buildTextFormField(
                    controller: textControllers.confirmpasswordController,
                    hintText: "lbl2".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    prefix: buildVisibilityIcon(toggleIVisibleEye, isVisiblePassword2),
                    suffix: buildLockIcon(),
                  ),
                  buildTermsAndConditionsRow(),
                  buildElevatedButton(context),
                  buildLoginPrompt(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFingerprintImage() {
    return CustomImageView(
      svgPath: ImageConstant.imgFingerprintLightGreen500,
      height: 163.v,
      width: 289.h,
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    Widget? prefix,
    Widget? suffix,  TextInputAction ?textInputAction, TextInputType? textInputType,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 22.v, right: 28.h),
            child: Text(
              hintText,
              style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
            ),
          ),
        ),
        CustomTextFormField(
          controller: controller,
          margin: EdgeInsets.only(left: 7.h, top: 3.v, right: 8.h),
          hintText: hintText,
          prefix: prefix,
          suffix: suffix,
          contentPadding: EdgeInsets.only(left: 30.h, top: 11.v, bottom: 11.v),
        ),
      ],
    );
  }

  Widget buildUserIcon() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: CustomImageView(
        svgPath: ImageConstant.imgUser,
      ),
    );
  }

  Widget buildCheckmarkIcon() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.h, 12.v, 20.h, 13.v),
      child: CustomImageView(
        svgPath: ImageConstant.imgCheckmark,
      ),
    );
  }

  Widget buildCallIcon() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.h, 13.v, 20.h, 12.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: CustomImageView(
        svgPath: ImageConstant.imgCall,
      ),
    );
  }

  Widget buildVisibilityIcon(VoidCallback onTap, bool isVisible) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.h, 11.v, 40.h, 14.v),
        child: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildLockIcon() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.h, 11.v, 20.h, 14.v),
      child: CustomImageView(
        svgPath: ImageConstant.imgLock,
      ),
    );
  }

  Widget buildTermsAndConditionsRow() {
    return Padding(
      padding: EdgeInsets.only(left: 27.h, top: 17.v, right: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "msg10".tr,
                  style: theme.textTheme.labelSmall,
                ),
                TextSpan(
                  text: "lbl7".tr,
                  style: CustomTextStyles.labelSmallLightgreen500_1,
                ),
                TextSpan(
                  text: "lbl8".tr,
                  style: theme.textTheme.labelMedium,
                ),
                TextSpan(
                  text: "lbl9".tr,
                  style: CustomTextStyles.labelSmallLightgreen500_1,
                ),
                TextSpan(
                  text: "lbl10".tr,
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: toggleCheckmark,
            child: buildCheckmarkContainer(),
          ),
        ],
      ),
    );
  }

  Widget buildCheckmarkContainer() {
    return Container(
      width: 17.0,
      height: 17.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: appTheme.gray400,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        children: [
          if (isCheckmarkVisible)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightGreen[500],
                ),
              ),
            ),
          Center(
            child: isCheckmarkVisible
                ? const Icon(
                    Icons.check,
                    size: 12.0,
                    color: Colors.white,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }


Widget buildElevatedButton(BuildContext context) {
  return CustomElevatedButton(
    text: "lbl11".tr,
    margin: EdgeInsets.only(left: 26.h, top: 56.v, right: 27.h),
    onTap: () async {
      // Assuming `UserController` is accessible in this scope.
      UserController userController = UserController();

     
      User user = User(
        username: textControllers.personalnameController.text,
        email: textControllers.emailaddressController.text,
        image: '', 
        fullName: textControllers.personalnameController.text,
        phone: textControllers.phonenumberoneController.text,
      );

      try {
        var result = await userController.create(user);

      
        if (result != null) {
        
          Navigator.pushReplacementNamed(context, '/login_screen');
        }

      } catch (e) {
        // Handle errors if necessary
        print("Error creating user: $e");
      }
    },
  );
}
  Widget buildLoginPrompt() {
    return Column(
      children: [
        SizedBox(height: 9.v),
        buildLoginRow(),
      ],
    );
  }

  Widget buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.loginScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "msg11".tr,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              Text(
                "lbl3".tr,
                style: CustomTextStyles.labelMediumLightgreen500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}












