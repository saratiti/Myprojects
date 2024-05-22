const UserChallenge = require('../models/userChallenge');
const  User  = require('../models/user');
const  ChallengeType  = require('../models/challengeType'); 

exports.createUserChallenge = async (req, res) => {
  try {
    const newUserChallenge = await UserChallenge.create(req.body);
    res.status(201).json({ message: 'User challenge created successfully', newUserChallenge });
  } catch (error) {
    console.error('Error creating user challenge:', error.message);
    res.status(500).send('Server Error');
  }
};
exports.completeChallenge = (userId, challengeId) => {
  try {
    UserChallenge.update(
      { status: 'completed' },
      {
        where: {
          userId: userId,
          challengeId: challengeId,
          status: { [Op.ne]: 'completed' }
        },
        returning: true
      }
    ).then(([updatedRows, userChallenge]) => {
      if (updatedRows > 0) {
        Challenge.findByPk(challengeId, { include: ChallengeType }).then(challenge => {
          if (challenge && challenge.ChallengeType) {
            const pointsEarned = challenge.ChallengeType.points;

            User.findByPk(userId).then(user => {
              if (user) {
                const newPoints = user.points + pointsEarned;
                user.update({ points: newPoints }).then(() => {
                  console.log(`User ${userId} completed challenge ${challengeId}. Points awarded: ${pointsEarned}.`);
                }).catch(error => {
                  console.error(`Error updating user points: ${error}`);
                });
              } else {
                console.log(`User ${userId} not found.`);
              }
            }).catch(error => {
              console.error(`Error finding user: ${error}`);
            });
          } else {
            console.log(`Challenge ${challengeId} or its challenge type not found.`);
          }
        }).catch(error => {
          console.error(`Error finding challenge: ${error}`);
        });
      } else {
        console.log('User challenge not found or already completed.');
      }
    }).catch(error => {
      console.error('Error completing challenge:', error);
    });
  } catch (error) {
    console.error('Error completing challenge:', error);
    throw error;
  }
};
