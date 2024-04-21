
import 'package:loyalty_app/model/product.dart';

class Cart {
  late int id;
  late int userId;
  late int productId;
  late int quantity;
  late Product product;

  Cart.fromJson(Map<String, dynamic> json) {
    id = int.parse(json["id"].toString());
    userId = int.parse(json["user_id"].toString());
    productId = int.parse(json["product_id"].toString());
    quantity = int.parse(json["quantity"].toString());
    product = Product.fromJson(json["product"]); 
  }

    Map<String, dynamic> toJson() => {
        
        "id": id,
        'product_id': productId,
        "product": product.toJson(),
       "quantity":quantity,
       
      };
}

