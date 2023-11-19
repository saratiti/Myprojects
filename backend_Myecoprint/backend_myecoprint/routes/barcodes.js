const express = require('express');
const router = express.Router();
const barcodeController = require('../controllers/barcodesController');

router.post('/barcodes', barcodeController.createBarcode);
router.get('/', barcodeController.getAllBarcodes);
router.get('/:id', barcodeController.getBarcodeById);
router.put('/barcodes/:id', barcodeController.updateBarcode);
router.delete('/barcodes/:id', barcodeController.deleteBarcode);
router.post('/scanQRCode',barcodeController.scanBarcode);
router.post('/generateBarcode',barcodeController.generateBarcode);
router.post('/checkBarcode', barcodeController.checkBarcode);
module.exports = router;

