
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/model/loyalty.dart';
import 'package:loyalty_app/model/product.dart';

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
      print(ex);
      rethrow;
    }
  }


  


}