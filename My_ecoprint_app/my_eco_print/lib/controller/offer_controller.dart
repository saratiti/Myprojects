
// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:my_eco_print/data/module/offer.dart';


import 'api_helper.dart';
class OfferController{

 late Dio dio;

  OfferController() {
    dio = Dio();
  }




  Future<dynamic> createOffer(Offer Offer) async {
    try {
  var result = await ApiHelper().postRequest("/api/Offers", Offer.toJson());
  print("Response: $result");
     print("JSON Data: ${Offer.toJson()}");
   

  return result;
} catch (e) {
  print("Error creating Offer: $e");
  print("JSON Data: ${Offer.toJson()}");

  rethrow;
}

  }

Future<Offer> getOffer() async {
  try {
    var result = await ApiHelper().getRequest("/api/Offers");
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
    dynamic jsonObject = await ApiHelper().getRequest("/api/Offers");
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

 Future<dynamic> deleteOffer(int OfferId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/Offers/$OfferId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}

 Future<List<Map<String, dynamic>>> fetchQRCodes() async {
    try {
      final response = await ApiHelper().getRequest("/api/offers/qrcodes");
      if (response != null) {
        return List<Map<String, dynamic>>.from(response);
      } else {
        throw Exception("No data received from the backend");
      }
    } catch (e) {
      print("Error fetching QR codes: $e");
      rethrow;
    }
  }
Future<Offer> getOfferById(int offerId) async {
  try {
    var result = await ApiHelper().getRequest("/api/Offers/$offerId");
    if (result != null) {
      return Offer.fromJson(result);
    } else {
      throw Exception("No data received from the backend");
    }
  } catch (e) {
    print("Error in getOfferById: $e");
    rethrow;
  }
}


}

