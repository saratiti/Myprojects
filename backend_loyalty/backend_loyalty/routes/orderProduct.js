
const express = require('express');
const router = express.Router();
const orderProductController = require('../controllers/orderProductController');


router.post('/', orderProductController.createOrderProduct);
router.get('/',orderProductController.getAllorderProduct);

module.exports = router;
