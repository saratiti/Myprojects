

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';


class ProductReview extends StatelessWidget {
  final Review review;

  const ProductReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
              RatingBar.builder(
                initialRating: review.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (_) {},
              ),
                Text(
                'Rating: ${review.rating.toStringAsFixed(1)}',
                style: const TextStyle(fontWeight: FontWeight.w200),
              ),
              Text(
                'By: ${review.user?.fullName?? 'Unknown User'}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(review.comment),
        ],
      ),
    );
  }
}
