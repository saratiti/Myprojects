
import 'package:loyalty_app/model/product.dart';

class OrderProduct {
  int id;
  int orderId;
  int productId;
  int sizeId;
  int colorId;
  int? qty;
  double price;
  String createdAt;
  String updatedAt;
  Product product;

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sizeId,
    required this.colorId,
    required this.qty,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'productId': productId,
      'sizeId': sizeId,
      'colorId': colorId,
      'qty': qty,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
  return OrderProduct(
    id: json['order_product_id'] as int? ?? 0,
    orderId: json['order_id'] as int? ?? 0,
    productId: json['product_id'] as int? ?? 0,
    sizeId: json['size_id'] as int? ?? 0,
    colorId: json['color_id'] as int? ?? 0,
    qty: json['qty'] as int?,
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    createdAt: json['created_at'] as String? ?? '',
    updatedAt: json['updated_at'] as String? ?? '',
    product: Product.fromJson(json['products']),
  );
}

}