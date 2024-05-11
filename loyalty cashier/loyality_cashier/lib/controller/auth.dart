
// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_declarations, use_build_context_synchronously


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loyality_cashier/model/login.dart';
import 'package:loyality_cashier/model/user.dart';
import 'package:loyality_cashier/view/auth/login_page.dart';




import 'api_helper.dart';

class AuthController{

 late Dio dio;

  UserController() {
    dio = Dio();
  }
Future<Login?> login(String email, String password) async {
  try {
    final Map<String, dynamic>? responseData = await ApiHelper().postRequest("/api/auth/login", {
      "email": email,
      "password": password,
    });

    if (responseData != null) {
      String accessToken = responseData['accessToken'];
      int userId = Jwt.parseJwt(accessToken)['user_id']; 
      return Login.fromJson(responseData, userId: userId); 
    } else {
      throw Exception('Login failed');
    }
  } catch (e) {
    print('Login error: $e');
    rethrow;
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
      var result = await ApiHelper().getRequest("/api/users/profile",);
      return User.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }



 
  Future<dynamic> create(User user) async {
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
        builder: (context) =>  const LoginPage(),
      ),
    );
  } catch (e) {
    print(e);

  }
}





}