
import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';
import 'package:loyality_cashier/model/category.dart';
import 'package:loyality_cashier/model/product.dart';


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

  
Future<List<Product>> getProductsByCategory(int categoryId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/product/$categoryId");
    if (kDebugMode) {
      print('Response from API: $jsonObject');
    } 
    List<Product> result = [];
    jsonObject.forEach((json) {
      result.add(Product.fromJson(json));
    });
    return result;
  } catch (ex) {
    if (kDebugMode) {
      print(ex);
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