
// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use, depend_on_referenced_packages


import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_eco_print/data/module/user.dart';
import 'package:my_eco_print/view/screen/auth/login_screen.dart';
import 'api_helper.dart';
import 'package:path/path.dart';

class UserController{

 late Dio dio;

  UserController() {
    dio = Dio();
  }


  Future<User> update({
  required String email,
  required String password,
  required String username,
  required String image,
  required String fullName,
  required String profilePicture,
  required String phone
}) async {
  try {
    var result = await ApiHelper().putRequest("/api/users/update", {
      "email": email,
      "password": password,
      "username": username,
      "image": image,
      "full_name":fullName,
      "profilePicture":profilePicture,
       "phone":profilePicture,
    });
    return User.fromJson(result);
  } catch (e) {
    rethrow;
  }
}


  Future<bool> updateUser(String email, String password, {String username = '', String image = ''}) async {
    try {
      

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


Future<User> getUser() async {
  try {
    var result = await ApiHelper().getRequest("/api/users/profile");
    if (result != null) {
      return User.fromJson(result);
    } else {
      throw Exception("No data received from the backend");
    }
  } catch (e) {
    print("Error in getUser: $e");
    rethrow;
  }
}



 
  Future<dynamic> create(User user) async {
try {
  var result = await ApiHelper().postDio("/api/users", user.toJson());
  print(result);
  return result;
} catch (e) {
  if (e is DioError) {
    if (e.type == DioErrorType) {
      print("Server error: ${e.response?.statusCode} - ${e.response?.data}");
    } else {
      print("Network error: $e");
    }
  }
  rethrow;
}



  }
Future<String> uploadImage(File file) async {
  try {
    var result = await ApiHelper().uploadPhoto(file);
    print(result); 
    if (Uri.tryParse(result) != null) {
      return result;
    } else {
  
      throw Exception("Invalid image URL: $result");
    }
  } catch (ex) {
    print(ex);
    rethrow;
  }
}



static Future<void> logout(BuildContext context) async {
  try {
 
    const storage = FlutterSecureStorage();
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


 Future<dynamic> deleteUser(int userId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/users/$userId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}
  Future<bool> exitEmail(String email) async {
    try {
      var result = await ApiHelper().postRequest("/api/users/emailExists", {
        "email": email,
      });

      if (result != null && result['exists'] != null) {
        return result['exists'];
      } else {

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

Future<Response> sendForm(
    String url, Map<String, dynamic> data, Map<String, File> files) async {
  Map<String, MultipartFile> fileMap = {};
  for (MapEntry fileEntry in files.entries) {
    File file = fileEntry.value;
    String fileName = basename(file.path);
    fileMap[fileEntry.key] =
        MultipartFile(file.openRead(), await file.length(), filename: fileName);
  }
  data.addAll(fileMap);
  var formData = FormData.fromMap(data);
  Dio dio = Dio();
  return await dio.post(url,
      data: formData, options: Options(contentType: 'multipart/form-data'));
}
Future<Response> sendFile(String url, File file) async {
  Dio dio = Dio();
  var len = await file.length();
  var response = await dio.post(url,
      data: file.openRead(),
      options: Options(headers: {
        Headers.contentLengthHeader: len,
      } 
          ));
  return response;
}

}