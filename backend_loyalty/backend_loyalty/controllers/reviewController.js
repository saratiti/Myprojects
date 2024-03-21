
const Review = require('../models/Review');

exports.createReview = async (req, res) => {
  try {
    const newReview = await Review.create(req.body);
    res.status(201).json({ message: 'Review created successfully', newReview });
  } catch (error) {
    console.error('Error creating review:', error.message);
    res.status(500).send('Server Error');
  }
};
