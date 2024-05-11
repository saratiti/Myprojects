

import 'package:loyality_cashier/model/challenge.dart';

class UserChallenge {
  final String ?status;
  final DateTime? completeDate;
  final int? userId;
  final int? challengeId;
  final int ?points;
  final Challenge? challenges;

  UserChallenge({
  this.status,
 this.completeDate,
    this.userId,
    this.challengeId,
    this.points,
    this.challenges,
  });

 factory UserChallenge.fromJson(Map<String, dynamic> json) {
  return UserChallenge(
    status: json['status'] ?? '',
    completeDate: json['complete_date'] != null ? DateTime.parse(json['complete_date']) : null,
    userId: json['user_id'] ?? 0,
    challengeId: json['challenge_id'] ?? 0,
    points: json['points'] ?? 0, 
    challenges: json['challenges'] != null ? Challenge.fromJson(json['challenges']) : null,
  );
}


  

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'complete_date': completeDate?.toIso8601String(),
      'user_id': userId,
      'challenge_id': challengeId,
      'points': points,
      'challenges': challenges?.toJson(),
    };
  }
}
