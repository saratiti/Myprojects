import 'dart:convert';

import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/model/review.dart';

class ReviewController {

Future<List<Review>> getProductReviews(int productId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/reviews/products/$productId");
    List<Review> result = [];
    List<dynamic>? reviews = jsonObject["reviews"];

    if (reviews != null) {
      reviews.forEach((reviewJson) {
        Review review = Review.fromJson(reviewJson);
        result.add(review);
      });
    }

    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}


  Future<dynamic> create(Review review) async {
    try {
      var result = await ApiHelper().postDio("/api/reviews", review.toJson());
      print(result);
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

Future<dynamic> deleteReview(int reviewId) async {
  try {
    var result = await ApiHelper().deleteRequest("/api/reviews/$reviewId");
    print(result);
    return result;
  } catch (e) {
    rethrow;
  }
}

}