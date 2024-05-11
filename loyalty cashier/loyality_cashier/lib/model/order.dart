
// ignore_for_file: non_constant_identifier_names


import 'package:loyality_cashier/model/order_product.dart';
import 'package:loyality_cashier/model/product.dart';

class Order {
  int? id;
  List<Product> products;
  List<OrderProduct>? orderProducts;
  Product? product;
  
  int? status_id;

  double total;
  //double tax_amount;
  //double sub_total;
  double total_price;

  // Constructor
  Order({
    this.id,
    this.orderProducts,
    required this.products,
    this.status_id,
    
    this.product,
 
    required this.total,
   // required this.sub_total,
    //required this.tax_amount,
    required this.total_price,
  });

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
     //   "sub_total": sub_total.toDouble(),
        //"tax_amount": tax_amount.toDouble(),
        "total": total.toDouble(),
        "total_price": total.toDouble(),
        
        "products": products.map((e) => e.toJson()).toList(),
      
        "product": product?.toJson(),
      };

  // Factory method to create an Order object from JSON data
factory Order.fromJson(Map<String, dynamic> json) {
  List<dynamic> orderProductData = json['orderProducts'] ?? [];
  List<OrderProduct>? orderProducts = orderProductData
      .map((item) => OrderProduct.fromJson(item))
      .toList();

  return Order(
    id: json['order_id'] as int?,
    orderProducts: orderProducts,
    products: (json['products'] != null)
        ? List<Product>.from(json['products'].map((e) => Product.fromJson(e)))
        : [],
   
    total: (json['total'] is String)
        ? double.tryParse(json['total'] ?? '0') ?? 0
        : (json['total'] as num?)?.toDouble() ?? 0,
    total_price: (json['total_price'] is String)
        ? double.tryParse(json['total_price'] ?? '0') ?? 0
        : (json['total_price'] as num?)?.toDouble() ?? 0,
    status_id: (json['status_id'] is String)
        ? int.tryParse(json['status_id'] ?? '0') ?? 0
        : (json['status_id'] as num?)?.toInt() ?? 0,
  );
}


}