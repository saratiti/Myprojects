const express = require('express');
const router = express.Router();
const pointController = require('../controllers/pointsController');
const { authenticateToken } = require('../middleware/authMiddleware');
router.post('/points', pointController.createPoint);
router.get('/', pointController.getAllPoints);
router.get('/points/:id', pointController.getPointById);
router.put('/points/:id', pointController.updatePoint);
router.delete('/points/:id', pointController.deletePoint);
router.post('/collectDaily',authenticateToken, pointController.collectDaily);
router.get('/total', authenticateToken, pointController.getTotalPointsByUserId);

module.exports = router;
