
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:my_eco_print/data/module/offer.dart';
import 'package:my_eco_print/data/module/store.dart';

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

Future<List<Offer>> getStoresWithOffers(int typeId) async {
  try {
    final response = await ApiHelper().getRequest("/api/stores/type/$typeId");

    if (response == null || response['data'] == null) {
      return [];
    }

    List<Offer> result = (response['data'] as List<dynamic>?)
        ?.map((json) {
        
          final offerJson = json['offer'];
          return Offer.fromJson(offerJson);
        })
        .toList() ?? [];

    return result;
  } catch (ex) {
    print('Error: $ex');
    rethrow;
  }
}


Future<List<Offer>> getAllStoresWithOffers() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/stores/typeByoffer");
      if (jsonObject == null) {
        return [];
      }
      List<Offer> result = [];
      jsonObject.forEach((json) {
        result.add(Offer.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
Future<List<Offer>> getOfferByStoreAndOfferId(int storeId, int offerId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/stores/$storeId/$offerId");
    if (jsonObject.containsKey("data") && jsonObject["data"].containsKey("offer")) {
      jsonObject = jsonObject["data"]["offer"];
    }
    List<Offer> result = [Offer.fromJson(jsonObject)];
    return result;
  } catch (e) {
    print(e);
    throw e; 
  }
}
}






