
import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';


class LoyaltyController {

  Future<Map<String, dynamic>> getLoyaltyDataByUser() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/loyalty/level");
      if (jsonObject == null) {
        return {'loyaltyLevel': null, 'loyaltyPoint': null};
      }
      
      return {
        'loyaltyLevel': jsonObject['loyalty_level'],
        'loyaltyPoint': jsonObject['loyalty_point'],
      };
      
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      rethrow;
    }
  }


  


}