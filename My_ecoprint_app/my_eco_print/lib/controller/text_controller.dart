import 'package:flutter/material.dart';

class TextControllers {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TextEditingController personalnameController = TextEditingController();

  TextEditingController emailaddressController = TextEditingController();

  TextEditingController phonenumberoneController = TextEditingController();

  TextEditingController passwordplacehoController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    personalnameController.dispose();
    phonenumberoneController.dispose();
    passwordplacehoController.dispose();
    confirmpasswordController.dispose();


  }
}