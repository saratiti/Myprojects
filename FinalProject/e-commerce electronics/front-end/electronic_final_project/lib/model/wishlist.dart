import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/model/user.dart';

class Wishlist {
  
int? id;
 
  int productId;

  Product? product;
  User?user;
  
  Wishlist({
 this.id,
 
    required this.productId,
 
    this.product,
    this.user,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'] as int?,
      productId: json["product_id"] as int? ?? 0,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    
      product: json['product'] != null ? Product.fromJson(json['product'] as Map<String, dynamic>) : null,
    );
    
  }
  Map<String, dynamic> toJson() => {
        
     "id": id,
        'product_id': productId,
        "product": product?.toJson(),
       
       
      };
}
