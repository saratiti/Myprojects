

const Challenge = require('../models/challenge');
const  ChallengeType  = require('../models/challengeType'); 
const UserChallenge=require('../models/userChallenge');


exports.getChallengesWithProgress = async (req, res) => {
  try {
    const authObject = req.user;

    const challenges = await Challenge.findAll({
      include: [
        {
          model: ChallengeType,
          as: 'challengeTypes', 
          attributes: ['type_name', 'required_count', 'points']
        }
      ]
    });

    const userProgress = await UserChallenge.findAll({ where: { user_id: authObject.user_id } });
    let totalPoints = 0;
    const challengesWithProgress = challenges.map(challenge => {
      const challengeProgress = userProgress.find(progress => progress.challengeId === challenge.challenge_id);
      const progressDetails = challengeProgress ? {
        status: challengeProgress.status,
        completeDate: challengeProgress.completeDate
      } : { status: 'Not started', completeDate: null };

      const isCompleted = challengeProgress && challengeProgress.status === 'completed';

      if (isCompleted) {
        totalPoints += challenge.ChallengeType.points;
      }

      return {
        id: challenge.challenge_id,
        name: challenge.challenge_name,
        description: challenge.challenge_descrption,
        type: challenge.ChallengeType.type_name,
        requiredCount: challenge.ChallengeType.requiredCount,
        points: challenge.ChallengeType.points,
        progress: progressDetails,
        isCompleted: isCompleted
      };
    });

   
    const today = new Date();
    const todayFormatted = new Date(today.getFullYear(), today.getMonth(), today.getDate()); 
    const hasParticipatedToday = userProgress.some(progress => {
      const progressDate = new Date(progress.createdAt);
      const progressDateFormatted = new Date(progressDate.getFullYear(), progressDate.getMonth(), progressDate.getDate());
      return progressDateFormatted.getTime() === todayFormatted.getTime();
    });

   
    if (hasParticipatedToday) {
      totalPoints += 50; 
    }

    res.status(200).json({ challenges: challengesWithProgress, totalPoints: totalPoints });
  } catch (error) {
    console.error('Error retrieving challenges with progress:', error);
    res.status(500).send('Server Error');
  }
};

exports.createChallenge = async (req, res) => {
  try {
    const newChallenge = await Challenge.create(req.body);
    res.status(201).json({ message: 'Challenge created successfully', newChallenge });
  } catch (error) {
    console.error('Error creating challenge:', error.message);
    res.status(500).send('Server Error');
  }
};