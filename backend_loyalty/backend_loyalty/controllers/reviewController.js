const Review = require('../models/review');
const Product = require('../models/product');
const User=require('../models/user')
const sequelize = require('sequelize');


exports.getReview = async (req, res) => {
  try {
    const user = req.user;
    const orders = await Review.query()
      .where('user_id', user.user_id)
      .with('product')
      .with('user')
      .orderBy('created_at', 'desc');
    return res.status(200).json({ data: orders });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve orders' });
  }
};

exports.getCount = async (req, res) => {
  try {
    const user = req.user;
    const count = await Review.count({
      where: { user_id: user.user_id }
    });
    return res.status(200).json({ count });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve review count' });
  }
};


exports.getTopRatedProducts = async (req, res) => {
  try {
    const topProducts = await Review.findAll({
      attributes: ['product_id', [sequelize.fn('avg', sequelize.col('rating')), 'averageRating']],
      group: ['product_id'],
      order: [[sequelize.literal('averageRating'), 'DESC']],
      limit: 10
    });
    

    const productIds = topProducts.map(item => item.product_id);

    const products = await Product.findAll({
      where: { id: { [sequelize.Op.in]: productIds } }
    });

    return res.status(200).json(products);
  } catch (error) {
    console.error('Error retrieving top-rated products:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};


exports.getProductReviews = async (req, res) => {
  try {
    const product = await Product.findOne({ where: { id: req.params.id } });
    if (!product) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const reviews = await Review.findAll({ 
      where: { product_id: product.id },
      include: [{ model: User, as: 'users' }]
    });

    let totalRatings = 0;
    reviews.forEach(review => {
      totalRatings += review.rating;
    });
    const averageRating = reviews.length > 0 ? totalRatings / reviews.length : 0;

    return res.status(200).json({ averageRating, reviews });
  } catch (error) {
    console.error('Error retrieving product reviews:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};




exports.updateReview = async (req, res) => {
  try {
    const review = await Review.find(req.params.id);

    if (!review) {
      return res.status(404).json({ message: `Review is not found with id of ${req.params.id}` });
    }

    if (review.user_id !== req.user.id && req.user.role !== 'admin') {
      return res.status(400).json({ message: 'Not authorized to update this review' });
    }

    review.merge(req.body);
    await review.save();

    return res.status(200).json({ status: 'success', data: review });
  } catch (error) {
    console.error('Error updating review:', error);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.create = async (req, res) => {
  const userId = req.user_id;
  const user = await User.findByPk(userId);
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  } 
  try {
    const review = await Review.create({
    user_id : userId,
   comment : req.body.comment,
    rating : req.body.rating,
   product_id :req.body.product_id,
  });
    await review.save();

    return res.status(201).json(review);
  } catch (error) {
    console.log(error);
    return res.status(400).json({ message: error.message });
  }
};

exports.destroy = async (req, res) => {
  try {
    const review = await Review.find(req.params.id);

    if (!review) {
      return res.status(404).json({ error: 'The Review does not exist.' });
    }

    if (review.user_id !== req.user.user_id) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    await review.delete();

    return res.status(200).json({ success: true, message: 'Review deleted successfully' });
  } catch (error) {
    console.error('Error deleting review:', error);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
};
