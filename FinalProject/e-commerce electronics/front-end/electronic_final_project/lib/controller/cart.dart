

import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/model/cart.dart';


class CartController {



  Future<dynamic> create(Cart cart) async {
    try {
      var result = await ApiHelper().postDio("/api/carts", cart.toJson());
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }

Future<List<Cart>> getUserCart() async {
  try {
    var result = await ApiHelper().getRequest("/api/carts");
    List<dynamic> data = result['data'];
    List<Cart> carts= data.map((item) => Cart.fromJson(item)).toList();
    return carts;
  } catch (e) {
    rethrow;
  }
}
Future<dynamic> deleteCart(int cartId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/carts/$cartId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }

}}