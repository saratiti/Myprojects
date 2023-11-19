
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ncej_admin/data/module/store.dart';
import 'api_helper.dart';
class StoreController{

 late Dio dio;

  StoreController() {
    dio = Dio();
  }




  Future<dynamic> createStore(Store store) async {
    try {
  var result = await ApiHelper().postRequest("/api/stores", store.toJson());
  print("Response: $result");
     print("JSON Data: ${store.toJson()}");
   

  return result;
} catch (e) {
  print("Error creating store: $e");
  print("JSON Data: ${store.toJson()}");

  rethrow;
}

  }

Future<Store> getStore() async {
  try {
    var result = await ApiHelper().getRequest("/api/stores");
    if (result != null) {
      return Store.fromJson(result);
    } else {
      throw Exception("No data received from the backend");
    }
  } catch (e) {
    print("Error in getUser: $e");
    rethrow;
  }
}

Future<List<Store>> getAll() async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/stores");
    if (jsonObject == null) {
      return [];
    }
    List<Store> result = [];
    jsonObject.forEach((json) {
      result.add(Store.fromJson(json));
    });
    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}

 Future<dynamic> deleteStore(int storeId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/stores/$storeId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}


}