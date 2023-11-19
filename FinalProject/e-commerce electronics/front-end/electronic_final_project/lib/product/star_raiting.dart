import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const StarRatingBar({
    required this.rating,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(Icons.star, size: size, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, size: size, color: Colors.grey);
        }
      }),
    );
  }
}
