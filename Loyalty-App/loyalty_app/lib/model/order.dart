
import 'package:loyalty_app/model/order_product.dart';
import 'package:loyalty_app/model/product.dart';

class Order {
  int? id;
  List<Product> products;
  List<OrderProduct>? orderProducts;
  Product? product;
  
  int? status_id;
  int payment_method_id;
  double total;
  //double tax_amount;
  double sub_total;
  double total_price;

  // Constructor
  Order({
    this.id,
    this.orderProducts,
    required this.products,
    this.status_id,
    
    this.product,
    required this.payment_method_id,
    required this.total,
    required this.sub_total,
    //required this.tax_amount,
    required this.total_price,
  });

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_total": sub_total.toDouble(),
        //"tax_amount": tax_amount.toDouble(),
        "total": total.toDouble(),
        "total_price": total.toDouble(),
        "payment_method_id": payment_method_id,
        "products": products.map((e) => e.toJson()).toList(),
      
        "product": product?.toJson(),
      };

  // Factory method to create an Order object from JSON data
  factory Order.fromJson(Map<String, dynamic> json) {
    List<dynamic> orderProductData = json['order_products'] ?? [];
    List<OrderProduct>? orderProducts = orderProductData
        .map((item) => OrderProduct.fromJson(item, item))
        .toList();

    return Order(
      id: json['id'] as int?,
      orderProducts: orderProducts,
      products: (json['products'] != null)
          ? List<Product>.from(json['products'].map((e) => Product.fromJson(e)))
          : [],
     
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      payment_method_id: (json['payment_method_id'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      total_price: (json['total_price'] as num?)?.toDouble() ?? 0.0,
     // tax_amount: (json['tax_amount'] as num?)?.toDouble() ?? 0.0,
      sub_total: (json['sub_total'] as num?)?.toDouble() ?? 0.0,
      status_id: (json['status_id'] as num?)?.toInt() ?? 0,
    );
  }
}
