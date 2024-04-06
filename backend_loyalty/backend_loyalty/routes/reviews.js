
const express = require('express');
const router = express.Router();
const reviewsController = require('../controllers/reviewController');
const { authenticateToken } = require('../middleware/authMiddleware');


router.get('/', reviewsController.getReview);
router.get('/count',authenticateToken ,reviewsController.getCount);
router.get('/topProducts', reviewsController.getTopRatedProducts);
router.get('/products/:id', reviewsController.getProductReviews);
router.put('/:id', reviewsController.updateReview);
router.post('/',authenticateToken, reviewsController.create);
router.delete('/:id', reviewsController.destroy);

module.exports = router;
