import 'package:flutter/material.dart';
import 'package:loyalty_app/model/user_challenge.dart';

class Challenge {
  final int id;
  final String name;
  final String description;
  final int challengeTypeId;
  final int totalPoints;
  //final UserChallenge progress;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.challengeTypeId,
    required this.totalPoints,
   // required this.progress,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      challengeTypeId: json['challengeTypeId'] ?? 0,
      totalPoints: json['totalPoints'] ?? 0,
      //progress: UserChallenge.fromJson(json['progress'] ?? {}), // Assuming progress is a nested JSON object
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'challengeTypeId': challengeTypeId,
      'totalPoints': totalPoints,
      //'progress': progress.toJson(), // Assuming progress can be converted to JSON
    };
  }
}
