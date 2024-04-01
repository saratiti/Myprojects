import 'dart:typed_data';

import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/challenge.dart';
import 'package:loyalty_app/model/challenge_type.dart';
import 'package:loyalty_app/model/invoice.dart';
import 'package:loyalty_app/model/user_challenge.dart';

class ChallengeController {
  final ApiHelper _apiHelper = ApiHelper();



Future<Map<String, dynamic>> getChallengesWithProgress() async {
    try {
      // Fetch challenges from the API
      var result = await _apiHelper.getRequest("/api/challenges/challengesProgress");
      List<dynamic>? data = result['challenges'];

      if (data != null) {
        // Retrieve all challenges with progress
        List<Challenge> challenges = [];
        List<UserChallenge> userProgress = await getUserChallengeProgress();

        for (var item in data) {
          // Access associated challenge type
          ChallengeType challengeType = ChallengeType.fromJson(item['challengeType']);
          // Access user progress for the current challenge
        UserChallenge challengeProgress = userProgress.firstWhere((progress) => progress.challengeId == item['id'], orElse: () => UserChallenge(status: 'Not started', completeDate: null, userId: 0, challengeId: 0, points: 0));

          // Calculate total points if challenge is completed
          int totalPoints = challengeProgress?.status == 'completed' ? challengeType.points : 0;

          // Build challenge object with progress details
          Challenge challenge = Challenge(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            challengeTypeId: item['challengeTypeId'],
            totalPoints: totalPoints,
          //  progress: challengeProgress ?? UserChallenge(status: 'Not started', completeDate: null, points: 0),
          );

          // Add challenge to the list
          challenges.add(challenge);
        }

        // Calculate total points
        int totalPoints = challenges.fold(0, (sum, challenge) => sum + challenge.totalPoints);

        // Return challenges with total points
        return {'challenges': challenges, 'totalPoints': totalPoints};
      } else {
        throw Exception('Failed to fetch challenges with progress: No data');
      }
    } catch (e) {
      throw Exception('Failed to fetch challenges with progress: $e');
    }
  }

  Future<List<UserChallenge>> getUserChallengeProgress() async {
    try {
      // Fetch user challenge progress from the API
      var result = await _apiHelper.getRequest("api/challenges/challengesProgress");
      List<dynamic>? data = result['challenges'];

      if (data != null) {
        // Convert API response to list of UserChallenge objects
        List<UserChallenge> progressList = data.map((item) => UserChallenge.fromJson(item)).toList();
        return progressList;
      } else {
        throw Exception('Failed to fetch user challenge progress: No data');
      }
    } catch (e) {
      throw Exception('Failed to fetch user challenge progress: $e');
    }
  }
}