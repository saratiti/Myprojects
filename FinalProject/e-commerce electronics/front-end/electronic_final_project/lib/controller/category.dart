import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/model/product.dart';

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


  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/categories/products/$categoryId");
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