
const express = require('express');
const router = express.Router();
const reviewsController = require('../controllers/reviewController');
const { authenticateToken } = require('../middleware/authMiddleware');

router.post('/', reviewsController.createReview);
router.get('/', reviewsController.getReview);
router.get('/count',authenticateToken ,reviewsController.getCount);
router.get('/top-rated-products', reviewsController.getTopRatedProducts);
router.get('/product/:id', reviewsController.getProductReviews);
router.get('/all', reviewsController.getAllReviews);
router.put('/:id', reviewsController.updateReview);
router.post('/', reviewsController.create);
router.delete('/:id', reviewsController.destroy);

module.exports = router;
