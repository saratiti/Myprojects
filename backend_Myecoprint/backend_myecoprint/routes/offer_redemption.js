const express = require('express');
const router = express.Router();
const { authenticateToken } = require('../middleware/authMiddleware');
const offerRedmptionController = require('../controllers/offer_redemptionController');


router.post('/',authenticateToken, offerRedmptionController.redeemPoints);
router.get('/totalRedeemed', authenticateToken, offerRedmptionController.getTotalRedeemedPoints);


module.exports = router;
