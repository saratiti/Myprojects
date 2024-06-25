

const Challenge = require('../models/challenge');
const  ChallengeType  = require('../models/challengeType'); 
const UserChallenge=require('../models/userChallenge');


// challengeController.js
// exports.getChallengesWithProgress = async (req, res) => {
//   try {
//     const authObject = req.user;

//     const challenges = await Challenge.findAll({
//       include: [{
//         model: ChallengeType,
//         as: 'challengeTypes',
//         attributes: ['type_name', 'required_count', 'points']
//       }]
//     });

//     const userProgress = await UserChallenge.findAll({ where: { user_id: authObject.user_id } });
//     let totalPoints = 0;
//     const challengesWithProgress = challenges.map(challenge => {
//       const challengeType = challenge.challengeTypes; // Access the associated ChallengeType
//       const challengeProgress = userProgress.find(progress => progress.challengeId === challenge.challenge_id);
//       const progressDetails = challengeProgress ? {
//         status: challengeProgress.status,
//         completeDate: challengeProgress.completeDate
//       } : { status: 'Not started', completeDate: null };

//       const isCompleted = challengeProgress && challengeProgress.status === 'completed';

//       if (isCompleted) {
//         totalPoints += challengeType.points; // Use the associated ChallengeType
//       }

//       return {
//         id: challenge.challenge_id,
//         name: challenge.challenge_name,
//         description: challenge.challenge_description,
//         type: challengeType ? challengeType.type_name : 'Unknown', // Check if challengeType exists
//         requiredCount: challengeType ? challengeType.required_count : 0, // Check if challengeType exists
//         points: challengeType ? challengeType.points : 0, // Check if challengeType exists
//         progress: progressDetails,
//         isCompleted: isCompleted
//       };
//     });

//     // Remaining code for calculating totalPoints and response

//     res.status(200).json({ challenges: challengesWithProgress, totalPoints: totalPoints });
//   } catch (error) {
//     console.error('Error retrieving challenges with progress:', error);
//     res.status(500).send('Server Error');
//   }
// };

exports.createChallenge = async (req, res) => {
  try {
    const newChallenge = await Challenge.create(req.body);
    res.status(201).json({ message: 'Challenge created successfully', newChallenge });
  } catch (error) {
    console.error('Error creating challenge:', error.message);
    res.status(500).send('Server Error');
  }
};
exports.processChallenges = async (req, res) => {
  try {
    const userId = req.user.user_id;

   
    const userChallenges = await UserChallenge.findAll({
      where: { user_id: userId }, 
      include: [
        {
          model: Challenge, 
          as: 'challenges', 
          include: [
            {
              model: ChallengeType, 
              as: 'challengeTypes', 
            }
          ]
        }
      ]
    });

    const response = {};
    userChallenges.forEach(userChallenge => {
      const challenge = userChallenge.challenge;
      if (!challenge) {
        response[userChallenge.challenge_id] = {
          message: `You have not started this challenge. You need to complete ${userChallenge.required_count} to finish.`,
          ...userChallenge.dataValues,
          remaining_count: userChallenge.required_count, 
          
          status: 'not_started'
        };
      } else if (userChallenge.status === 'completed') {
        response[challenge.challenge_id] = {
          message: `You have completed this challenge. Required count was ${userChallenge.required_count}.`,
          ...userChallenge.dataValues,
          
          current_count: userChallenge.complete_count,
          remaining_count: 0,
          status: 'completed'
        };
      } else if (userChallenge.complete_count >= userChallenge.required_count) {
        response[challenge.challenge_id] = {
          message: `You have completed this challenge. Required count was ${userChallenge.required_count}.`,
          ...userChallenge.dataValues,
          current_count: userChallenge.complete_count,
          remaining_count: 0,
          status: 'completed'
        };
        userChallenge.update({ status: 'completed' });
      } else {
        const remainingCount = userChallenge.required_count - userChallenge.complete_count;
        response[challenge.challenge_id] = {
          message: `You are in progress for this challenge. Required count is ${userChallenge.required_count}.`,
          ...userChallenge.dataValues,
          current_count: userChallenge.complete_count,
          remaining_count, 
          status: 'in_progress'
        };
      }
    });

    res.json(response); 
  } catch (error) {
    console.error('Error processing challenges:', error);
    res.status(500).json({ error: 'Internal server error' }); 
  }
};

exports.getAllChallenges = async (req, res) => {
  try {
    const challenges = await Challenge.findAll({
      include: [{
        model: ChallengeType,
        as: 'challengeTypes',
        attributes: ['type_name', 'required_count', 'points']
      }]
    });

    res.status(200).json({ challenges });
  } catch (error) {
    console.error('Error retrieving challenges:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};