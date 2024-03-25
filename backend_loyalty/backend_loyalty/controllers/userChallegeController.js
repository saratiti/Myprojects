

const UserChallenge = require('../models/userChallenge');

exports.createUserChallenge = async (req, res) => {
  try {
    const newUserChallenge = await UserChallenge.create(req.body);
    res.status(201).json({ message: 'User challenge created successfully', newUserChallenge });
  } catch (error) {
    console.error('Error creating user challenge:', error.message);
    res.status(500).send('Server Error');
  }
};
