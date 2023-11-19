
import 'package:electronic_final_project/model/color.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/model/size.dart';

import 'api_helper.dart';

class ProductController {



 Future<List<ColorProduct>> getProductByColor(int productId) async {
  try {
    List<ColorProduct> result = [];
    var response = await ApiHelper().getRequest("api/products/color/$productId");

    if (response is List<dynamic>) {
      response.forEach((v) {
        result.add(ColorProduct.fromJson(v));
      });
    }

    return result;
  } catch (ex) {
    rethrow;
  }
}

 Future<List< SizeProduct>> getProductBySize(int productId) async {
  try {
    List<SizeProduct> result = [];
    var response = await ApiHelper().getRequest("api/products/size/$productId");

    if (response is List<dynamic>) {
      response.forEach((v) {
        result.add(SizeProduct.fromJson(v));
      });
    }
    return result;
  } catch (ex) {
    rethrow;
  }
}

  Future<List<Product>> getById(int productId) async {
    try {
      List<Product> products = [];
      var response = await ApiHelper().getRequest("/api/products/$productId");
   response.forEach((v) {
        products.add(Product.fromJson(v));
      });

      return products;
    } catch (ex) {
      rethrow;
    }
  }


    Future<List<Product>> getTopRatedProducts() async {
    try {
      List<Product> products = [];
      var response = await ApiHelper().getRequest("/api/reviews/products");

      if (response is List<dynamic>) {
        response.forEach((v) {
          products.add(Product.fromJson(v));
        });
      }

      return products;
    } catch (ex) {
      rethrow;
    }
  }
}
