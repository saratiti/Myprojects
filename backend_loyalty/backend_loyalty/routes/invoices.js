

const express = require('express');
const router = express.Router();
const invoiceController = require('../controllers/invoiceController');
const { authenticateToken } = require('../middleware/authMiddleware');


router.get('/', authenticateToken,invoiceController.getAllInvoicesByUserId);

router.post('/upload', authenticateToken, invoiceController.createInvoice);
router.get('/image', authenticateToken,invoiceController.getInvoiceImages);
module.exports = router;
