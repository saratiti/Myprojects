
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import 'api_helper.dart';

import 'package:my_eco_print/data/module/type.dart';

class TypeController{

 late Dio dio;

  TypeController() {
    dio = Dio();
  }



Future<List<Type>> getAll() async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/types",);
    if (jsonObject == null) {
      return [];
    }
    List<Type> result = [];
    jsonObject.forEach((json) {
      result.add(Type.fromJson(json));
    });
    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}







}