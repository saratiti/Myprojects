import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/api_helper.dart';


class UserProfileModel extends ChangeNotifier {
  String? _profilePicture;
  int _totalPointsRedeemed = 0;
  int _totalPoints = 0;


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

Future<int> get totalPoints async {
  try {
    
    var result = await ApiHelper().getRequest("/api/points/total");

    if (result.containsKey('totalPoints')) {
      var totalPoints = result['totalPoints'];

      if (totalPoints != null) {
        return totalPoints['total_points'] ?? 0;
      } else {
        print("Error: 'totalPoints' value is null");
        return 0;
      }
    } else {
      print("Error: 'totalPoints' key is missing in the API response");
      return 0;
    }
  } catch (e) {
    print("Error getting total points: $e");
    throw e; 
  }
}

 void updateTotalPointsRedeemed(int points) {
    _totalPointsRedeemed = points;
    notifyListeners();
  }
  
  void updateTotalPoints(int points) {
    _totalPoints = points;
    notifyListeners();
  }
}