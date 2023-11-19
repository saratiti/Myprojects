const express = require('express');
const router = express.Router();
const reasonBarcodesController = require('../controllers/reason_barcodesController');

router.post('/reasonBarcodess', reasonBarcodesController.createreasonBarcode);
router.get('/', reasonBarcodesController.getAllreasonBarcodes);
router.get('/reasonBarcodess/:id', reasonBarcodesController.getreasonBarcodeById);
router.put('/reasonBarcodess/:id', reasonBarcodesController.updatereasonBarcode);
router.delete('/reasonBarcodess/:id', reasonBarcodesController.deletereasonBarcode);

module.exports = router;
