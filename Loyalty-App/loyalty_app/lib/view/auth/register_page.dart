// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController usernameController;
  final GlobalKey<FormState> _registerformKey = GlobalKey<FormState>();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _fullNameFocusNode;
  late FocusNode _usernameFocusNode;
  late FocusNode _phoneFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _fullNameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _fullNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  void _handleSignUpAction(BuildContext context) async {
    EasyLoading.show(status: "Loading");

    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;
    String enteredFullName = fullNameController.text;
    //String enteredusername=usernameController.text;
    String enteredPhone = phoneController.text;

    UserController userController = UserController();
    User user = User(
      // username: enteredusername,

      email: enteredEmail,
      image: '',
      fullName: enteredFullName,
      phone: enteredPhone,
      password: enteredPassword,
    );

    try {
      var result = await userController.create(user);

      if (result != null) {
        Navigator.pushReplacementNamed(context, '/login_page');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error creating user: $e");
      }
    }

    EasyLoading.dismiss();
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
              key: _registerformKey,
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
                                        "Register",
                                        style: CustomTextStyles
                                            .titleMediumMulishffd1512d,
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
                      _buildFullName(context),
                      SizedBox(height: 29.v),
                      _buildEmail(context),
                      SizedBox(height: 29.v),
                      _buildPhone(context),
                      SizedBox(height: 29.v),
                      _buildPassword(context),
                      SizedBox(height: 31.v),
                      _buildSignUp(context),
                      SizedBox(height: 30.v),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
   ) );
  }

  Widget _buildFullName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 32.h,
            right: 39.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Full Name",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: fullNameController,
                focusNode: _fullNameFocusNode,
                 cursorColor:appTheme.deepOrange800,
                hintText: "Full Name",
                textInputType: TextInputType.text,
                prefix: const Icon(Icons.person, color: Colors.grey),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 32.h,
            right: 39.h,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Username",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: usernameController,
                focusNode: _usernameFocusNode,
                 cursorColor:appTheme.deepOrange800,
                hintText: "Username",
                textInputType: TextInputType.text,
                prefix: const Icon(Icons.person, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
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
         cursorColor:appTheme.deepOrange800,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        prefix: const Icon(Icons.email, color: Colors.grey),
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      child: CustomTextFormField(
        controller: phoneController,
        focusNode: _phoneFocusNode,
         cursorColor:appTheme.deepOrange800,
        hintText: "Phone",
        textInputType: TextInputType.phone,
        prefix: const Icon(Icons.phone, color: Colors.grey),
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
         cursorColor:appTheme.deepOrange800,
        hintText: "lbl2".localized,
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

  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        _handleSignUpAction(context);
      },
      height: 60.v,
      text: "Sign Up",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 39.h,
      ),
      buttonStyle: CustomButtonStyles.outlineBlue,
      buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
    );
  }
}
