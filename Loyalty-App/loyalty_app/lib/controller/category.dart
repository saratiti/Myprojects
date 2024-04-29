
import 'package:flutter/foundation.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/model/product.dart';

class CategoryController {

  Future<List<Catalog>>getAll() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
      if (jsonObject == null) {
        return [];
      }
      List<Catalog> result = [];
      jsonObject.forEach((json) {
        result.add(Catalog.fromJson(json));
      });
      return result;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      rethrow;
    }
  }

 Future<List<Catalog>> getFirstThree() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
      if (jsonObject == null) {
        return [];
      }
      List<Catalog> result = [];
      int count = 0;
      jsonObject.forEach((json) {
        if (count < 3) {
          result.add(Catalog.fromJson(json));
          count++;
        } else {
          return result; 
        }
      });
      return result;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      rethrow;
    }
  }

Future<List<Product>> getProductsByCategory(int id) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/product/$id");
    
   
    print('Response Body: $jsonObject');
    
 
    if (jsonObject == null) {
      throw Exception('Response body is null');
    }
    
   
    if (jsonObject is List<dynamic> && jsonObject.isNotEmpty) {
    
      List<Product> result = [];
      for (var json in jsonObject) {
        if (json is Map<String, dynamic>) {
          try {
            result.add(Product.fromJson(json));
          } catch (e) {
            print('Error parsing product JSON: $e');
          }
        } else {
          print('Invalid product format in the response');
        }
      }
      return result;
    } 
    

    else {
      throw Exception('Invalid response format or empty response');
    }
  } catch (ex) {
    if (kDebugMode) {
      print('Error fetching products: $ex');
    }
    rethrow;
  }
}





  Future<List<Catalog>> getCategoryById(int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories/$categoryId");
      List<Catalog> result = [];
      jsonObject.forEach((json) {
        result.add(Catalog.fromJson(json));
      });
      return result;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      rethrow;
    }
  }




}