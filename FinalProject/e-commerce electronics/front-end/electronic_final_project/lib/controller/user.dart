import 'dart:io';

import 'package:dio/dio.dart';
import 'package:electronic_final_project/auth/login.dart';
import 'package:electronic_final_project/model/register.dart';
import 'package:electronic_final_project/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Model/login.dart';
import 'api_helper.dart';

class UserController{

 late Dio _dio;

  UserController() {
    _dio = Dio();
  }
  Future<Login> login(String email, String password) async {
    try {
      var result = await ApiHelper().postRequest("/api/users/login", {
        "email": email,
        "password": password,
      });
      return Login.fromJson(result);
    } catch (e) {
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


  Future<bool> updateUser(String email, String password, {String username = '', String image = ''}) async {
    try {
      

      return true; // Update successful
    } catch (e) {
      print(e);
      return false; // Update failed
    }
  }


  Future<User> getUser() async {
    try {
      var result = await ApiHelper().getRequest("/api/users");
      return User.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }



 
  Future<dynamic> create(Register user) async {
    try {
      var result = await ApiHelper().postDio("/api/users", user.toJson());
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }
 Future<String> uploadImage(File file) async {
    try {
      var result = await ApiHelper().uploadImage(file,"/api/users/storage");
      print(result);
      return result["path"];
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }


static Future<void> logout(BuildContext context) async {
  try {
 
    final storage = FlutterSecureStorage();
    await storage.deleteAll();

 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  } catch (e) {
    print(e);

  }
}





}