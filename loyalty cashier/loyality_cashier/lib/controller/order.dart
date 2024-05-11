


import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';
import 'package:loyality_cashier/model/order.dart';




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
      if (kDebugMode) {
        print(result);
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

Future<dynamic> deleteOrder(int orderId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/orders/cashier/$orderId");
    if (kDebugMode) {
      print(result);
    }
    return result;
  } catch (e) {
    rethrow;
  }
}



  Future<List<Order>> getAllOrders() async {
    try {
      var result = await ApiHelper().getRequest("/api/orders");
      List<dynamic> data = result['data'];
      List<Order> orders = data.map((item) => Order.fromJson(item)).toList();
      return orders;
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }



}
