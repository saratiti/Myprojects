
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ncej_admin/data/module/offer.dart';
import 'api_helper.dart';
class OfferController{

 late Dio dio;

  OfferController() {
    dio = Dio();
  }


  Future<Offer> update({
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
    return Offer.fromJson(result);
  } catch (e) {
    rethrow;
  }
}

  Future<dynamic> createOffer(Offer offer) async {
    try {
  var result = await ApiHelper().postRequest("/api/offers", offer.toJson());
  print("Response: $result");
     print("JSON Data: ${offer.toJson()}");
   

  return result;
} catch (e) {
  print("Error creating offer: $e");
  print("JSON Data: ${offer.toJson()}");

  rethrow;
}

  }

Future<Offer> getOffer() async {
  try {
    var result = await ApiHelper().getRequest("/api/users/profile");
    if (result != null) {
      return Offer.fromJson(result);
    } else {
      throw Exception("No data received from the backend");
    }
  } catch (e) {
    print("Error in getUser: $e");
    rethrow;
  }
}

Future<List<Offer>> getAll() async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/offers");
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

 Future<dynamic> deleteOffer(int offerId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/offers/$offerId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}








}