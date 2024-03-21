

const Loyalty = require('../models/loyalty');

exports.getAllLoyalties = async (req, res) => {
  try {
    const loyalties = await Loyalty.findAll();
    res.json(loyalties);
  } catch (error) {
    console.error('Error retrieving loyalties:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createLoyalty = async (req, res) => {
  try {
    const newLoyalty = await Loyalty.create(req.body);
    res.status(201).json({ message: 'Loyalty created successfully', newLoyalty });
  } catch (error) {
    console.error('Error creating loyalty:', error.message);
    res.status(500).send('Server Error');
  }
};
