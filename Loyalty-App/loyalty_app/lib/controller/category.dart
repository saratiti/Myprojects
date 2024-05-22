
import 'package:flutter/foundation.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/model/product.dart';

class CategoryController {
final ApiHelper _apiHelper = ApiHelper();
  // Future<List<Catalog>>getAll() async {
  //   try {
  //     dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
  //     if (jsonObject == null) {
  //       return [];
  //     }
  //     List<Catalog> result = [];
  //     jsonObject.forEach((json) {
  //       result.add(Catalog.fromJson(json));
  //     });
  //     return result;
  //   } catch (ex) {
  //     if (kDebugMode) {
  //       print(ex);
  //     }
  //     rethrow;
  //   }
  // }
Future<List<Catalog>> getAllCategory() async {
  try {
    var result = await _apiHelper.getRequest("/api/categories");
    List<dynamic>? data = result['categories'];
    if (data != null) {
      List<Catalog> categories = [];
      
     
      for (var item in data) {
       
        List<Uint8List> imageList = await _apiHelper.getCategoryImages(item['image']);
        
        categories.add(Catalog(
          categoryId: item['id'],
          nameArabic: item['name_arabic'],
          logo:item['image'],
          nameEnglish: item['name_english'],
          imageBytesList: imageList,
        ));
      }
      return categories;
    } else {
      throw Exception('Failed to fetch categories: No data');
    }
  } catch (e) {
    throw Exception('Failed to fetch  categories: $e');
  }
}

Future<List<Catalog>> getFirstThree() async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
    if (jsonObject == null) {
      return [];
    }
    List<Catalog> result = [];
    for (var category in jsonObject['categories']) {
      result.add(Catalog.fromJson(category));
    }
    return result.take(3).toList();
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