
// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:dio/dio.dart';
import 'package:my_eco_print/data/module/Point.dart';
import 'package:my_eco_print/data/module/transaction.dart';

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
      var totalPoints = result['totalPoints']['total_points'];
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
Future<int> getTotalPointsRedeemedByUserId() async {
  try {
    var result = await ApiHelper().getRequest("/api/redeem_points/totalRedeemed");

    if (result is int) {
      return result;
    } else if (result is Map<String, dynamic> && result.containsKey('totalRedeemedPoints')) {
      // If the result is a map and has a 'totalRedeemedPoints' key, attempt to extract the value
      var totalRedeemedPoints = result['totalRedeemedPoints'];

      if (totalRedeemedPoints is int) {
        return totalRedeemedPoints;
      } else {
        print("Error: 'totalRedeemedPoints' is not an integer");
        return 0; 
      }
    } else {
      print("Error: Unexpected response format");
      return 0; 
    }
  } catch (e) {
    print("Error getting totalRedeemedPoints: $e");
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

    print("Request Payload: ${{
      'storeId': storeId.toString(),
      'offerId': offerId.toString(),
      'pointsRedeemed': pointsRedeemed.toString(),
    }}");

    
    if (result != null && result['success'] != null) {
      bool success = result['success']; 
      if (success) {
       
        Transaction localTransaction = Transaction(
          storeId: storeId,
          offerId: offerId,
          points: pointsRedeemed,
          transactionType: 'redemption',
          transactionDate: DateTime.now(),
        );
      }
    }

    return result;
  } catch (e) {
    print("Error redeeming points: $e");
    rethrow;
  }
}

Future<int> collectDailyPoints() async {
  try {
    var result = await ApiHelper().postRequest("/api/points/collectDaily", {});
    print("Response Body: $result");

    
   if (result.containsKey('dailyPoints')) {
      var dailyPoints = int.tryParse(result['dailyPoints'].toString());
      if (dailyPoints != null) {
        return dailyPoints;
      } else {
        print("Error: Unable to parse 'dailyPoints' as int");
        return 0; 
      }
    } else {
      print("Error: 'dailyPoints' key is missing in the API response");
      return 0; 
    }
  } catch (e) {
    print("Error getting dailyPoints: $e");
    rethrow;
  }
}




}

