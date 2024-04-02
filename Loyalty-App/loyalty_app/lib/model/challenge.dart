import 'package:flutter/material.dart';
import 'package:loyalty_app/model/challenge_type.dart';
import 'package:loyalty_app/model/user_challenge.dart';

class Challenge {
  final int id;
  final String name;
  final String description;
  final int challengeTypeId;
final  ChallengeType? challengeType;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.challengeTypeId,
    this.challengeType,
   
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['challenge_id'] ?? 0,
      name: json['challenge_name'] ?? '',
      description: json['challenge_description'] ?? '',
      challengeTypeId: json['challengType_id'] ?? 0,
      challengeType: json['challengeType'] != null ? ChallengeType.fromJson(json['challengeType']) : null, // Handle nested object correctly
      //progress: UserChallenge.fromJson(json['progress'] ?? {}), // Assuming progress is a nested JSON object
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'challengeTypeId': challengeTypeId,
    
      //'progress': progress.toJson(), // Assuming progress can be converted to JSON
    };
  }
}
