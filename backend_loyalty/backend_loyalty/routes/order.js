

const express = require('express');
const router = express.Router();
const ordersController = require('../controllers/orderController');


router.get('/', ordersController.getOrder);
router.get('/count', ordersController.getCountOrder);
router.post('/', ordersController.create);
router.delete('/:id', ordersController.destroy);

module.exports = router;
