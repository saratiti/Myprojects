

const express = require('express');
const router = express.Router();
const ordersController = require('../controllers/orderController');
const { authenticateToken } = require('../middleware/authMiddleware');

router.get('/', ordersController.getOrder);
router.get('/count', ordersController.getCountOrder);
router.post('/',authenticateToken, ordersController.create);
router.delete('/:id', ordersController.destroy);

module.exports = router;
