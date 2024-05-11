import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';


class UserProfileModel extends ChangeNotifier {
  String? _profilePicture;


  String? get profilePicture => _profilePicture;

 
  void updateProfilePicture(String imageUrl) {
    _profilePicture = imageUrl;
    notifyListeners(); 
  }


 

 
 

Future <int> get totalPointsRedeemed async{
   try {
    var result = await ApiHelper().getRequest("/api/redeem_points/totalRedeemed");

    if (result is int) {
      return result;
    } else if (result is Map<String, dynamic> && result.containsKey('totalRedeemedPoints')) {
     
      var totalRedeemedPoints = result['totalRedeemedPoints'];

      if (totalRedeemedPoints is int) {
        return totalRedeemedPoints;
      } else {
        if (kDebugMode) {
          print("Error: 'totalRedeemedPoints' is not an integer");
        }
        return 0; 
      }
    } else {
      if (kDebugMode) {
        print("Error: Unexpected response format");
      }
      return 0; 
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error getting totalRedeemedPoints: $e");
    }
    rethrow;
  }




}

Future<int> get totalPoints async {
  try {
    
    var result = await ApiHelper().getRequest("/api/points/total");

    if (result.containsKey('totalPoints')) {
      var totalPoints = result['totalPoints'];

      if (totalPoints != null) {
        return totalPoints['total_points'] ?? 0;
      } else {
        if (kDebugMode) {
          print("Error: 'totalPoints' value is null");
        }
        return 0;
      }
    } else {
      if (kDebugMode) {
        print("Error: 'totalPoints' key is missing in the API response");
      }
      return 0;
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error getting total points: $e");
    }
    rethrow; 
  }
}

 void updateTotalPointsRedeemed(int points) {
    notifyListeners();
  }
  
  void updateTotalPoints(int points) {
    notifyListeners();
  }
}