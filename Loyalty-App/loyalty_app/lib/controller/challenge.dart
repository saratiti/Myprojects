
import 'package:flutter/foundation.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/challenge.dart';

import 'package:loyalty_app/model/user_challenge.dart';

class ChallengeController {
  final ApiHelper apiHelper = ApiHelper();

Future<List<Challenge>> getUserChallenges() async {
  try {
    dynamic response = await apiHelper.getRequest("/api/challenges");
    List<Challenge> result = [];

    if (response != null && response['challenges'] is List<dynamic>) {
      for (var item in response['challenges']) {
        result.add(Challenge.fromJson(item));
      }
    } else {
      if (kDebugMode) {
        print("API response is not a list");
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