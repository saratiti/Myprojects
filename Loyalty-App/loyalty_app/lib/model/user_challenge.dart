import 'package:loyalty_app/model/challenge.dart';

class UserChallenge {
  final String status;
  final DateTime? completeDate;
  final int? userId;
  final int? challengeId;
  final int points;
  final Challenge? challenge;

  UserChallenge({
    required this.status,
    required this.completeDate,
    this.userId,
    this.challengeId,
    required this.points,
    this.challenge,
  });

  factory UserChallenge.fromJson(Map<String, dynamic> json) {
  return UserChallenge(
    status: json['status'] ?? '', // Provide default value if null
    completeDate: json['complete_date'] != null ? DateTime.parse(json['complete_date']) : null,
    userId: json['user_id'] ?? 0, // Provide default value if null
    challengeId: json['challenge_id'] ?? 0, // Provide default value if null
    points: json['points'] ?? 0, // Provide default value if null
    challenge: json['challenge'] != null ? Challenge.fromJson(json['challenge']) : null, // Handle nested object
  );
}

  

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'complete_date': completeDate?.toIso8601String(),
      'user_id': userId,
      'challenge_id': challengeId,
      'points': points,
      'challenge': challenge?.toJson(),
    };
  }
}
