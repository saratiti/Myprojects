

import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/product.dart';

class BrandController{


  Future<List<Brand>>getAll() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/brands");
      if (jsonObject == null) {
        return [];
      }
      List<Brand> result = [];
      jsonObject.forEach((json) {
        result.add(Brand.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

Future<List<Brand>> getBrandsByCategoryId(int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/products/categories/$categoryId");
      List<Brand> result = [];
      jsonObject.forEach((json) {
        result.add(Brand.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
    Future<List<Product>> getProductsByBrandAndCategory(int brandId, int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/products/brands/$brandId/categories/$categoryId");
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






}