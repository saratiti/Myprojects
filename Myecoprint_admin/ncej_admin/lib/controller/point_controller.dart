
// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:dio/dio.dart';
import 'package:ncej_admin/data/module/point.dart';
import 'package:ncej_admin/data/module/transaction.dart';


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

Future<Map<String, dynamic>> redeemPoints({
  required int storeId,
  required int offerId,
  required int pointsRedeemed,
  required String scannedData,
}) async {
  try {
    var result = await ApiHelper().postDio(
      "/api/redeem_points",
      {
        'storeId': storeId.toString(),
        'offerId': offerId.toString(),
        'pointsRedeemed': pointsRedeemed.toString(),
        'scannedData': scannedData, // Include scannedData in the request payload
      },
    );

    print("Request Payload: ${{
      'storeId': storeId.toString(),
      'offerId': offerId.toString(),
      'pointsRedeemed': pointsRedeemed.toString(),
      'scannedData': scannedData,
    }}");

    print("Response Body: $result");

    if (result != null && result['success'] != null) {
      bool success = result['success'];

      if (success) {
        print("Redemption successful");

        // Parse the barcodeInfo from the backend response
        Map<String, dynamic>? barcodeInfo = result['barcodeInfo'];
        if (barcodeInfo != null) {
          // Display barcode information (modify based on your UI requirements)
          print('Barcode Information: $barcodeInfo');
        }
      } else {
        print("Redemption failed");
      }
    }

    return result;
  } catch (e) {
    if (e is DioError) {
      print("DioError response: ${e.response?.data}");
    }
    print("Error redeeming points: $e");
    print("Request Parameters: { 'storeId': $storeId, 'offerId': $offerId, 'pointsRedeemed': $pointsRedeemed, 'scannedData': $scannedData }");

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

