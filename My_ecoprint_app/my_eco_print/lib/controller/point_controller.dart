
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:my_eco_print/data/module/Point.dart';

import 'api_helper.dart';
class PointController{

 late Dio dio;

  PointController() {
    dio = Dio();
  }




  Future<dynamic> createPoint(Point Point) async {
    try {
  var result = await ApiHelper().postRequest("/api/points", Point.toJson());
  print("Response: $result");
     print("JSON Data: ${Point.toJson()}");
   

  return result;
} catch (e) {
  print("Error creating Point: $e");
  print("JSON Data: ${Point.toJson()}");

  rethrow;
}

  }

Future<Point> getPoint() async {
  try {
    var result = await ApiHelper().getRequest("/api/points");
    if (result != null) {
      return Point.fromJson(result);
    } else {
      throw Exception("No data received from the backend");
    }
  } catch (e) {
    print("Error in getUser: $e");
    rethrow;
  }
}

Future<List<Point>> getAll() async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/points");
    if (jsonObject == null) {
      return [];
    }
    List<Point> result = [];
    jsonObject.forEach((json) {
      result.add(Point.fromJson(json));
    });
    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}

 Future<dynamic> deletePoint(int pointId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/Points/$pointId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}

Future<List<Point>> getPointsWithOffers(int typeId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/points/type/$typeId");
      if (jsonObject == null) {
        return [];
      }
      List<Point> result = [];
      jsonObject.forEach((json) {
        result.add(Point.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
Future<List<Point>> getAllPointsWithOffers() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/points/typeByoffer");
      if (jsonObject == null) {
        return [];
      }
      List<Point> result = [];
      jsonObject.forEach((json) {
        result.add(Point.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
Future<int> getTotalPointsByUserId() async {
  try {
    var result = await ApiHelper().getRequest("/api/points/total");
    if (result.containsKey('totalPoints')) {
      var totalPoints = int.tryParse(result['totalPoints'].toString());
      if (totalPoints != null) {
        return totalPoints;
      } else {
        print("Error: Unable to parse 'totalPoints' as int");
        return 0; 
      }
    } else {
      print("Error: 'totalPoints' key is missing in the API response");
      return 0; 
    }
  } catch (e) {
    print("Error getting total points: $e");
    rethrow;
  }
}
Future<dynamic> redeemPoints({
  required int storeId,
  required int offerId,
  required int pointsRedeemed,
}) async {
  try {
    var result = await ApiHelper().postDio(
      "/api/redeem_points",
      {
        'storeId': storeId.toString(),
        'offerId': offerId.toString(),
        'pointsRedeemed': pointsRedeemed.toString(),
      },
    );


    print("Points redeemed successfully: $result");
        print("Request Payload: ${{
  'storeId': storeId.toString(),
  'offerId': offerId.toString(),
  'pointsRedeemed': pointsRedeemed.toString(),
}}");
    return result;
  } catch (e) {
    print("Error redeeming points: $e");
    rethrow;
  }
}
}