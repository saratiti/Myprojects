

import 'package:electronic_final_project/controller/api_helper.dart';

import 'package:electronic_final_project/model/wishlist.dart';

class WishlistController {

Future<List<Wishlist>> getProductWishlist(int productId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/wishlists/products/$productId");
    List<Wishlist> result = [];
    List<dynamic>? wishlists = jsonObject["wishlists"];
    if (wishlists != null) {
      wishlists.forEach((wishlistJson) {
        Wishlist wishlist = Wishlist.fromJson(wishlistJson);
        result.add(wishlist);
      });
    }
    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}

  Future<dynamic> create(Wishlist wishlist) async {
    try {
      var result = await ApiHelper().postDio("/api/wishlists", wishlist.toJson());
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }

Future<List<Wishlist>> getUserWhishlist() async {
  try {
    var result = await ApiHelper().getRequest("/api/wishlists");
    List<dynamic> data = result['data'];
    List<Wishlist> whislists= data.map((item) => Wishlist.fromJson(item)).toList();
    return whislists;
  } catch (e) {
    rethrow;
  }
}
Future<dynamic> deleteWishlist(int whishlistId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/wishlists/$whishlistId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }

}}