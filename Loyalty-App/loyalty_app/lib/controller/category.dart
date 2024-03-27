
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/model/product.dart';

class CategoryController {

  Future<List<Category>>getAll() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
      if (jsonObject == null) {
        return [];
      }
      List<Category> result = [];
      jsonObject.forEach((json) {
        result.add(Category.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

 Future<List<Category>> getFirstThree() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories");
      if (jsonObject == null) {
        return [];
      }
      List<Category> result = [];
      int count = 0;
      jsonObject.forEach((json) {
        if (count < 3) {
          result.add(Category.fromJson(json));
          count++;
        } else {
          return result; // If you've fetched the first three, you can return here
        }
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  
Future<List<Product>> getProductsByCategory(int categoryId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/product/$categoryId");
    print('Response from API: $jsonObject'); // Print response
    List<Product> result = [];
    jsonObject.forEach((json) {
      result.add(Product.fromJson(json));
    });
    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}

  Future<List<Category>> getCategoryById(int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories/$categoryId");
      List<Category> result = [];
      jsonObject.forEach((json) {
        result.add(Category.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }




}