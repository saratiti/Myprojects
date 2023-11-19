
import 'dart:convert';

import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/model/order.dart';
import 'package:electronic_final_project/model/order_product.dart';

class OrderController {




  Future<List<Order>> getUserOrders() async {
    try {
      var result = await ApiHelper().getRequest("/api/orders");
      List<dynamic> data = result['data'];
      List<Order> orders = data.map((item) => Order.fromJson(item)).toList();
      return orders;
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }



Future<int> getCountOrder() async {
  try {
    var result = await ApiHelper().getRequest("/api/orders/count");
    int orderCount = result['count'];
    return orderCount;
  } catch (e) {
    rethrow;
  }

}

  Future<dynamic> create(Order order) async {
    try {
      var result = await ApiHelper().postDio("/api/orders", order.toJson());
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }

Future<dynamic> deleteOrder(int orderId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/orders/$orderId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}



}


