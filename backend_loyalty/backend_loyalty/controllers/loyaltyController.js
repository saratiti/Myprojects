

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

exports.getLoyaltyLevelByUser = async (req, res) => {
  try {
    const userId = req.user;
    const loyalty = await Loyalty.findOne({ where: { user_id: userId.user_id } });

    if (!loyalty) {
      return res.status(404).json({ error: 'Loyalty record not found for the user' });
    }

    const newLevel = calculateLoyaltyLevel(loyalty.loyalty_point);

    // Update loyalty_level and loyalty_point
    await loyalty.update({ loyalty_level: newLevel });

    // Send response with loyalty level and loyalty point
    res.json({ loyalty_level: newLevel, loyalty_point: loyalty.loyalty_point });
  } catch (error) {
    console.error('Error retrieving loyalty level:', error.message);
    res.status(500).json({ error: 'Server Error' });
  }
};

const calculateLoyaltyLevel = (loyaltyPoint) => {
  if (loyaltyPoint >= 2000) {
    return 'Gold';
  } else if (loyaltyPoint >= 1000) {
    return 'Silver';
  } else {
    return 'Bronze';
  }
};