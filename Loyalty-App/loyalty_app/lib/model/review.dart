
import 'package:loyalty_app/model/product.dart';
import 'package:loyalty_app/model/user.dart';

class Review {
  
int? id;
  double rating;
  int productId;
  int ?userId;
  String comment;
  Product? product;
  User?user;

  Review({
 this.id,
    required this.rating,
    required this.productId,
    this.userId,
    required this.comment,
    this.product,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int?,
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      productId: json["product_id"] as int? ?? 0,
      userId: json["user_id"]as int? ?? 0,
      comment: json["comment"] as String? ?? "",
       user: json['users'] != null ? User.fromJson(json['users'] as Map<String, dynamic>) : null,
    
      product: json['product'] != null ? Product.fromJson(json['product'] as Map<String, dynamic>) : null,
    );
  }
  Map<String, dynamic> toJson() => {
        
        "id": id,
        'rating': rating,
        'product_id': productId,
        'comment': comment,
        "product": product?.toJson(),
        "user_id":userId,
        "user":user?.toJson(),
       
       
      };
}
