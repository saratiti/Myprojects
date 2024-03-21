

const Challenge = require('../models/challenge');

exports.getAllChallenges = async (req, res) => {
  try {
    const challenges = await Challenge.findAll();
    res.json(challenges);
  } catch (error) {
    console.error('Error retrieving challenges:', error.message);
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
