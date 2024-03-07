import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double radius;
  final double strokeWidth;
  final int progress;
  final Color color;

  const CircularProgressBar({
    required this.radius,
    required this.strokeWidth,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: CircularProgressIndicator(
        value: progress / 100,
        strokeWidth: strokeWidth,
        color: color,
      ),
    );
  }
}
