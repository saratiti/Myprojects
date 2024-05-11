


import 'package:flutter/foundation.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/order.dart';



class OrderController {
  Future<List<Order>> getUserOrders() async {
    try {
      var result = await ApiHelper().getRequest("/api/orders/orderByUser");
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

 Future<dynamic> create(Map<String, dynamic> orderData) async {
  try {
    var result = await ApiHelper().postDio("/api/orders", orderData);
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
    var result = await ApiHelper().deleteRequest("/api/orders/$orderId");
    if (kDebugMode) {
      print(result);
    }
    return result;
  } catch (e) {
    rethrow;
  }
}









}


