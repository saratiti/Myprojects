
const express = require('express');
const router = express.Router();
const orderProductController = require('../controllers/orderProductController');


router.post('/', orderProductController.createOrderProduct);

module.exports = router;
