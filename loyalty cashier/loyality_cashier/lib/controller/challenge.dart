
import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';
import 'package:loyality_cashier/model/user_challenge.dart';


class ChallengeController {
  final ApiHelper apiHelper = ApiHelper();

Future<List<UserChallenge>> getUserChallenge() async {
  try {
    dynamic jsonObject = await apiHelper.getRequest("/api/challenges/challengesProgress");
    List<UserChallenge> result = [];

   
    if (jsonObject != null) {
     
      if (jsonObject is Map<String, dynamic>) {
       
        jsonObject.forEach((key, value) {
        
          result.add(UserChallenge.fromJson(value));
        });
      } else {
        if (kDebugMode) {
          print("API response is not a map");
        }
      }
    } else {
      if (kDebugMode) {
        print("API response is null");
      }
    }

    return result;
  } catch (ex) {
    if (kDebugMode) {
      print(ex);
    }
    rethrow;
  }
}







}