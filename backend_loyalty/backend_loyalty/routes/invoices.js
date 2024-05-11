

const express = require('express');
const router = express.Router();
const invoiceController = require('../controllers/invoiceController');
const { authenticateToken } = require('../middleware/authMiddleware');


router.get('/', authenticateToken,invoiceController.getAllInvoicesByUserId);
router.get('/all',invoiceController.getAllInvoices);
router.get('/:invoiceId',invoiceController.getInvoicesById);
router.post('/upload', authenticateToken, invoiceController.createInvoice);
router.get('/image', authenticateToken,invoiceController.getInvoiceImages);
router.post('/scan',  authenticateToken,invoiceController.scanInvoice);
router.post('/barcode',invoiceController.generateBarcodeInvoice);

module.exports = router;
