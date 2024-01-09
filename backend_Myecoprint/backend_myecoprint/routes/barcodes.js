const express = require('express');
const router = express.Router();
const { authenticateToken } = require('../middleware/authMiddleware');
const barcodeController = require('../controllers/barcodesController');

router.post('/', barcodeController.createBarcode);
router.get('/', barcodeController.getAllBarcodes);
router.get('/:id', barcodeController.getBarcodeById);
router.put('/barcodes/:id', barcodeController.updateBarcode);
router.delete('/barcodes/:id', barcodeController.deleteBarcode);
router.post('/scanQRCode',barcodeController.scanBarcode);
router.post('/generateBarcode',barcodeController.generateBarcode);
router.post('/offerstoreBarcode',authenticateToken,barcodeController.generateBarcodeOfferStore);
router.post('/checkBarcode', barcodeController.checkBarcode);
//router.post('/pointsFrombarcodes',barcodeController.collectPointsFromBarcode)
module.exports = router;

