
// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use, depend_on_referenced_packages, unrelated_type_equality_checks


import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loyality_cashier/model/user.dart';
import 'package:loyality_cashier/view/auth/login_page.dart';


import 'api_helper.dart';
import 'package:path/path.dart';

class UserController{

 late Dio dio;

  UserController() {
    dio = Dio();
  }

Future<bool> changePassword(String email, String newPassword, String confirmPassword) async {
  try {
    var result = await ApiHelper().post("/api/users/changedPassword", {
      "email": email,
      "confirmPassword": confirmPassword,
      "newPassword": newPassword,
    });

    if (result != null && result['message'] == 'Password updated successfully') {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error changing password: $e');
    return false;
  }
}


  Future<User> update({
  required String email,
  required String password,
  required String username,
 
  required String fullName,
  required String profilePicture,
  required String phone
}) async {
  try {
    var result = await ApiHelper().putRequest("/api/users/update", {
      "email": email,
      "password": password,
      "username": username,
      
      "full_name":fullName,
      "profile_picture":profilePicture,
       "phone":phone,
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
        builder: (context) =>  const LoginPage(),
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
Future<Map<String, dynamic>> sendPinForEmailVerification(String email) async {
  try {
    
    var result = await ApiHelper().postRequest("/api/users/sendPinForEmail", {
      "email": email,
    });

    
    if (result != null) {
 
      print('Raw Response: $result');

     
      if (result is Map<String, dynamic> && result['success'] != null) {
        bool success = result['success'];

        if (success) {
          
          bool emailExists = result['exists'] ?? false; 

          if (emailExists) {
           
            String hashedCode = result['hashedCode'] ?? ''; 
            print('Received Hashed Code: $hashedCode');
            print('Email exists');
          } else {
           
            print('Email not found.');
          }
        } else {
          print('Failed to receive hashed code from the backend');
        }
      } else {
        print('Invalid response from the backend');
      }
    } else {
      print('Response is null'); 
    }


    return result ?? {}; 
    
  } catch (error) {
   
    print('Error: $error');
   
  
    return {};
  }
}





Future<bool> verifyPinCode(BuildContext context, String userEmail, String pinController) async {
  try {
    String pin = pinController;

    var response = await ApiHelper().postDio("/api/users/validPin", {
      "email": userEmail,
      "pin": pin,
    });

    // Print the entire response for debugging
    print('Dio Response: $response');

    if (response != null) {
      try {
        var result = response;

        if (result is Map<String, dynamic> && result.containsKey('success')) {
          if (result['success']) {
            // Extract the hashed PIN from the response
            String? hashedPin = result['hashedPin'];

            if (hashedPin != null) {
              // Print the received hashed PIN
              print('Received Hashed PIN from backend: $hashedPin');
              print('PIN code is correct');

             
              return true;
            } else {
              print('Unexpected response format: Missing hashedPin field');
            }
          } else {
            
            if (response.statusCode == 401) {
              
              print(result.containsKey('message') ? result['message'] : 'Your request is unauthorized. Please check your PIN and try again.');
            } else {
             
              print(result.containsKey('message') ? result['message'] : 'Incorrect PIN code');
            }
          }
        } else {
          print('Unexpected response format: Response does not contain success field');
        }
      } catch (e) {
        print('Error parsing response data: $e');
      }
    } else {
      print('Unexpected response format: Response is null');
    }

    return false;
  } catch (e) {
    print('Error during PIN code verification: $e');
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