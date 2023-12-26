
// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_declarations, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ncej_admin/data/module/login.dart';
import 'package:ncej_admin/data/module/register.dart';
import 'package:ncej_admin/data/module/user.dart';
import 'package:ncej_admin/view/screen/auth/login_screen.dart';

import 'api_helper.dart';

class AuthController{

 late Dio dio;

  UserController() {
    dio = Dio();
    //  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //     };
  }
   Future<Login?> login(String username, String password) async {
    final Map<String, dynamic>? responseData = await ApiHelper().postRequest("/api/auth/login", {
        "username":username,
        "password": password,
      });

    if (responseData != null) {
      return Login.fromJson(responseData);
    } else {
      return null;
    }
  }

  Future<User> update({
  required String email,
  required String password,
  required String username,
  required String image,
}) async {
  try {
    var result = await ApiHelper().putRequest("/api/users", {
      "email": email,
      "password": password,
      "username": username,
      "image": image,
    });
    return User.fromJson(result);
  } catch (e) {
    rethrow;
  }
}


  

  Future<User> getUser() async {
    try {
      var result = await ApiHelper().getRequest("/api/users/profile");
      return User.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }



 
  Future<dynamic> create(Register user) async {
    try {
      var result = await ApiHelper().postDio("/api/auth/register", user.toJson());
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }


static Future<void> logout(BuildContext context) async {
  try {
 
    final storage = const FlutterSecureStorage();
    await storage.deleteAll();

 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  } catch (e) {
    print(e);

  }
}





}