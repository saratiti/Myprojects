

const express = require('express');
const router = express.Router();
const loyaltyController = require('../controllers/loyaltyController');


router.get('/', loyaltyController.getAllLoyalties);


router.post('/', loyaltyController.createLoyalty);

module.exports = router;
