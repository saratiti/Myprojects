

const express = require('express');
const router = express.Router();
const ordersController = require('../controllers/orderController');
const { authenticateToken } = require('../middleware/authMiddleware');

router.get('/', ordersController.getAllorder);
router.get('/count', ordersController.getCountOrder);
router.post('/',authenticateToken, ordersController.create);
router.delete('/:orderId',authenticateToken, ordersController.destroy);
router.delete('/cashier/:orderId',ordersController.destroyOrderCashier);
router.get('/orderByUser',authenticateToken, ordersController.getAllorderProductByUserId);

module.exports = router;
