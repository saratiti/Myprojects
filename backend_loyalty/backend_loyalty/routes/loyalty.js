

const express = require('express');
const router = express.Router();
const loyaltyController = require('../controllers/loyaltyController');
const { authenticateToken } = require('../middleware/authMiddleware');

router.get('/', loyaltyController.getAllLoyalties);
router.get('/level',authenticateToken,loyaltyController.getLoyaltyLevelByUser);


router.post('/', loyaltyController.createLoyalty);

module.exports = router;
