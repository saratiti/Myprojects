// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


import 'package:dio/dio.dart';

class ApiHelper {
  final String DOMAIN = "myecoprint.etarsd.com";

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    bool check = await storage.containsKey(key: "token");
    if (check) {
      String result = await storage.read(key: "token") as String;
      return result;
    }
    return "";
  }

  Future<dynamic> getRequest(String path) async {
    Uri uriFunction =  Uri.https(DOMAIN, path);

    var token = await getToken();

    var headers = {"Authorization": "Bearer $token "};

    http.Response response = await http.get(uriFunction, headers: headers);

    return resposneFunction(response);
  }

  Future<dynamic> postRequest(String path, Map body) async {
    Uri uriFunction =  Uri.https(DOMAIN, path);

    var token = await getToken();

    http.Response response = await http.post(
      uriFunction,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return resposneFunction(response);
  }

  Future<dynamic> post(String path, Map body) async {
    Uri uriFunction =  Uri.https(DOMAIN, path);

    http.Response response = await http.post(
      uriFunction,
      body: body,
    );

    return resposneFunction(response);
  }

  Future<dynamic> putRequest(String path, Map body) async {
    Uri uri =  Uri.https(DOMAIN, path);

    var token = await getToken();

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    String jsonBody = json.encode(body);

    http.Response response =
        await http.put(uri, body: jsonBody, headers: headers);

    return resposneFunction(response);
  }



  Future<dynamic> deleteRequest(String path) async {
    Uri uriFunction =  Uri.https(DOMAIN, path);
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    http.Response response = await http.delete(uriFunction, headers: headers);
    return resposneFunction(response);
  }

  dynamic resposneFunction(http.Response response) {
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthorized";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        throw "Not Found";
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  }

  Future<dynamic> postDio(String path, Map<String, dynamic> body) async {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};
    Uri uriFunction =  Uri.https(DOMAIN, path);
    try {
      Response response = await dio.post(
        uriFunction.toString(),
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 301) {
        // Handle redirection
        String newUrl = e.response!.headers['location']![0];
        Response redirectedResponse = await dio.post(
          newUrl,
          data: body,
          options: Options(
            headers: headers,
          ),
        );
        return redirectedResponse.data;
      } else {
        rethrow;
      }
    }
  }

  Future<Uint8List> postDioForImage(String path, Map body,
      {int? userId}) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};
 Uri uriFunction =  Uri.https(DOMAIN, path);
    if (userId != null) {
      body['userId'] = userId;
    }

    Response response = await dio.post(
      uriFunction.toString(),
      data: body,
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.data is List<int>) {
          return Uint8List.fromList(response.data);
        } else {
          throw "Invalid image data received";
        }
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthorized";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        throw "Not Found";
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  }

 Future<String> uploadPhoto(File photoFile) async {
    try {
      var token = await getToken();
      var headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      };

      Uri uri = Uri.https(DOMAIN, '/api/users/upload');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath(
          'photo',
          photoFile.path,
          filename: photoFile.path.split("/").last,
        ));

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body.toString();
      } else {
        throw "Failed to upload photo. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Error uploading photo: $e";
    }
  }

  Future<String> uploadProfilePicture(File profilePicture) async {
    try {
      var token = await getToken();
      var headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      };

      Uri uri = Uri.https(DOMAIN, '/api/users/updateProfile');

      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          profilePicture.path,
          filename: profilePicture.path.split("/").last,
        ));

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body.toString();
      } else {
        throw "Failed to upload profile picture. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Error uploading profile picture: $e";
    }
  }



 dynamic responseFunction(http.Response response) {
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthorized";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        throw "Not Found";
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  }
Future<Uint8List?> getProfilePicture() async {
  try {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    
    Uri uri = Uri.https(DOMAIN, '/api/users/profilePicture');

    Response response = await dio.get(
      uri.toString(), 
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.data is List<int>) {
          return Uint8List.fromList(response.data);
        } else {
          throw "Invalid image data received";
        }
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthorized";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        return null;
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching profile picture: $e');
    }
    return null;
  }
}



Future<Uint8List?> getProfilePictureCompany(String companyId) async {
    try {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

 
    Uri uri = Uri.https(DOMAIN,'/api/companies/$companyId');

    Response response = await dio.get(
      uri.toString(), // Convert Uri to String
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.data is List<int>) {
          return Uint8List.fromList(response.data);
        } else {
          throw "Invalid image data received";
        }
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthorized";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        return null;
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching profile picture: $e');
    }
    return null;
  }

}
}