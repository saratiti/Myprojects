import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class ApiHelper {
  final String DOMAIN = "192.168.1.117:3333";

  Future<String> getToken() async {
    var storage = FlutterSecureStorage();
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
    var headers = {"Authorization": token};
    http.Response resposne = await http.get(uriFunction, headers: headers);
    return resposneFunction(resposne);
  }

  Future<dynamic> postRequest(String path, Map body) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
    http.Response resposne = await http.post(uriFunction, body: body);
    return resposneFunction(resposne);
  }
Future<dynamic> putRequest(String path, Map body) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
    var token = await getToken();
    var headers = {"Authorization": token};
    http.Response resposne =
        await http.put(uriFunction, body: body, headers: headers);
    return resposneFunction(resposne);
  }
  Future<dynamic> deleteRequest(String path) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
    var token = await getToken();
    var headers = {"Authorization": token};

    http.Response response = await http.delete(uriFunction, headers: headers);
    return resposneFunction(response);
  }
 dynamic resposneFunction(http.Response response) {
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

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

  Future postDio(String path, Map body) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": token};

    Response response = await dio.post(
      'http://$DOMAIN$path',
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthrizied";
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
  Future uploadImage(File file, urlPath) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": token};

    FormData formData = FormData.fromMap({
      "image_file": await MultipartFile.fromFile(file.path,
          filename: file.path.split("/").last)
    });
    Response response = await dio.post(
      'http://$DOMAIN$urlPath',
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthrizied";
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

}