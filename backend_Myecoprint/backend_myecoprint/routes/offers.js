const express = require('express');
const router = express.Router();
const offerController = require('../controllers/offersController');
const path = require('path');
const fs = require('fs');
const Offer=require('../models/offer');
router.post('/', offerController.createOffer);
router.get('/', offerController.getAllOffers);
//router.get('/:id', offerController.getOfferById);
router.put('/offers/:id', offerController.updateOffer);
router.delete('/:id', offerController.deleteOffer);
router.get('/P', offerController.getFilteredOffers);
router.get('/store',offerController.getStoresByOffer);
const sharp = require('sharp');


const qrCodeDirectory = 'public/qrcodes';

router.get('/qrcodes/list', async (req, res) => {
    try {
      const offers = await Offer.findAll();
  
      if (!offers || offers.length === 0) {
        return res.status(404).json({ error: 'No offers found' });
      }
  
      const imagePaths = [];
  
      for (const offer of offers) {
        const barcodeImageFilePath = path.join(qrCodeDirectory, `offer_${offer.offer_id}.png`);
  
        if (fs.existsSync(barcodeImageFilePath)) {
          imagePaths.push(barcodeImageFilePath);
        }
      }
  
      if (imagePaths.length > 0) {
        // Set the appropriate content type for images
        res.setHeader('Content-Type', 'image/png');
  
        // Stream each image to the response
        imagePaths.forEach((imagePath) => {
          fs.createReadStream(imagePath).pipe(res);
        });
  
        return;
      }
  
      res.status(404).json({ error: 'No barcode images found' });
    } catch (err) {
      console.error('Error querying the database:', err);
      res.status(500).json({ error: 'Failed to fetch offer data' });
    }
  });
  
router.get('/qrcodes/:filename', async (req, res) => {
    const filename = req.params.filename;
    const qrCodeDirectory = 'public/qrcodes';
    const qrCodeImagePath = path.join(qrCodeDirectory, filename);
  
    const imageBuffer = await offerController.readAndRetrieveQRCodeImage(qrCodeImagePath);
  
    if (imageBuffer) {
      res.setHeader('Content-Type', 'image/png'); 
      res.send(imageBuffer);
    } else {
      res.status(404).send('QR Code image not found');
    }
  });
  
  
module.exports = router;

