const express = require('express');
const transactionController = require('../controllers/transactionController');
const router = express.Router();
const { authenticateToken } = require('../middleware/authMiddleware');

router.get('/', authenticateToken,transactionController.getAllTransactionsByUser);

module.exports = router;
