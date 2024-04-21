
import 'package:flutter/foundation.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/product.dart';
import 'package:loyalty_app/model/review.dart';

class ReviewController {

Future<List<Review>> getProductReviews(int productId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/reviews/products/$productId");
    List<Review> result = [];
    List<dynamic>? reviews = jsonObject["reviews"];

    if (reviews != null) {
      for (var reviewJson in reviews) {
        Review review = Review.fromJson(reviewJson);
        result.add(review);
      }
    }

    return result;
  } catch (ex) {
    if (kDebugMode) {
      print(ex);
    }
    rethrow;
  }
}


  Future<dynamic> create(Review review) async {
    try {
      var result = await ApiHelper().postDio("/api/reviews", review.toJson());
      if (kDebugMode) {
        print(result);
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

Future<List<Review>> getUserReview() async {
  try {
    var result = await ApiHelper().getRequest("/api/reviews");
    List<dynamic> data = result['data'];
    List<Review> reviews= data.map((item) => Review.fromJson(item)).toList();
    return reviews;
  } catch (e) {
    rethrow;
  }
}
Future<int> getCountReview() async {
  try {
    var result = await ApiHelper().getRequest("/api/reviews/count");
    int reviewCount = result['count'];
    return reviewCount;
  } catch (e) {
    rethrow;
  }

}
Future<List<Product>> getTopRatedProducts() async {
    try {
      List<Product> products = [];
      var response = await ApiHelper().getRequest("/api/reviews/topProducts");

      if (response is List<dynamic>) {
        for (var v in response) {
          products.add(Product.fromJson(v));
        }
      }

      return products;
    } catch (ex) {
      rethrow;
    }
  }



Future<dynamic> deleteReview(int reviewId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/reviews/$reviewId");
    if (kDebugMode) {
      print(result);
    }
    return result;
  } catch (e) {
    rethrow;
  }
}

}