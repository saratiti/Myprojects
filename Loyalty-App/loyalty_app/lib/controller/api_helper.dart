// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;



class ApiHelper {
  final String DOMAIN = "192.168.1.144:3000";

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
  Uri uriFunction = Uri.http(DOMAIN, path);

  var token = await getToken();
  

  var headers = {"Authorization": "Bearer $token"};
  

  http.Response response = await http.get(uriFunction, headers: headers);
  

  return resposneFunction(response);
}

  Future<dynamic> postRequest(String path, Map body) async {
    Uri uriFunction = Uri.http(DOMAIN, path);

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
    Uri uriFunction = Uri.http(DOMAIN, path);

    http.Response response = await http.post(
      uriFunction,
      body: body,
    );

    return resposneFunction(response);
  }

Future<dynamic> putRequest(String path, Map body) async {
  Uri uri = Uri.http(DOMAIN, path);
  
  // Get the token
  var token = await getToken();
  
  
  var headers = {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json", 
  };


  String jsonBody = json.encode(body);


  http.Response response = await http.put(uri, body: jsonBody, headers: headers);


  return resposneFunction(response);
}

  Future<dynamic> deleteRequest(String path) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
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

  Future<dynamic> postDio(String path, Map body) async {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    try {
      Response response = await dio.post(
        'http://$DOMAIN$path',
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        token = await getToken();
        headers = {"Authorization": "Bearer $token"};

        Response response = await dio.post(
          'http://$DOMAIN$path',
          data: body,
          options: Options(
            headers: headers,
          ),
        );
        return response.data;
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

    if (userId != null) {
      body['userId'] = userId;
    }

    Response response = await dio.post(
      'http://$DOMAIN$path',
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
      final dio = Dio();
      var token = await getToken();
      var headers = {"Authorization": "Bearer $token"};
      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          photoFile.path,
          filename: photoFile.path.split("/").last,
        ),
      });
      Response response = await dio.post(
        'http://$DOMAIN/api/users/upload',
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data.toString();
      } else {
        throw "Failed to upload photo. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "Error uploading photo: $e";
    }
  }

Future<String> uploadInvoice(File invoiceFile) async {
  try {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    if (invoiceFile.path.endsWith('.pdf') ||
        invoiceFile.path.endsWith('.doc') ||
        invoiceFile.path.endsWith('.docx') ||
        invoiceFile.path.endsWith('.jpeg') ||
        invoiceFile.path.endsWith('.jpg') ||
        invoiceFile.path.endsWith('.png')) {
      String fileName = "invoice.${invoiceFile.path.split("/").last}";

FormData formData = FormData.fromMap({
  "invoice": await MultipartFile.fromFile(
    invoiceFile.path,
    filename: fileName,
  ),
});


      Response response = await dio.post(
        'http://$DOMAIN/api/invoices/upload', 
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data.toString();
      } else {
        throw "Failed to upload invoice. Status code: ${response.statusCode}";
      }
    } else {
      throw "Only PDF, DOC, DOCX, JPEG, PNG files are allowed";
    }
  } catch (e) {
    throw "Error uploading invoice: $e";
  }
}

Future<List<Uint8List>> getInvoiceImages(String imagePath) async {
  try {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    Response response = await dio.get(
      'http://$DOMAIN/api/invoices/image',
      options: Options(
        headers: headers,
        responseType: ResponseType.json, 
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        List<Uint8List> imageList = [];
        Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('images')) {
          List<dynamic> images = responseData['images'];
          for (var imageData in images) {
            if (imageData.containsKey('dataUrl')) {
              // Extract and decode the base64-encoded image data
              String dataUrl = imageData['dataUrl'];
              String base64Image = dataUrl.split(',').last;
              Uint8List decodedImage = base64Decode(base64Image);
              imageList.add(decodedImage);
            }
          }
          return imageList;
        } else {
          throw "Invalid response format";
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

        return [];
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching invoice images: $e');
    }
    return []; 
  }
}


Future<Uint8List?> getProfilePictureCompany(String companyId) async {
  try {
    final dio = Dio();
    var token = await getToken();
    var headers = {"Authorization": "Bearer $token"};

    Response response = await dio.get(
      'http://$DOMAIN/api/companies/$companyId', 
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