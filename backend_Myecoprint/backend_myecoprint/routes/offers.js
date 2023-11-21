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




router.get('/qrcodes', async (req, res) => {
  const qrCodeDirectory = 'public/qrcodes';

  try {
    const qrCodeFiles = fs.readdirSync(qrCodeDirectory);
    const qrCodeImages = await Promise.all(
      qrCodeFiles.map(async (filename) => {
        const qrCodeImagePath = path.join(qrCodeDirectory, filename);
        const imageBuffer = await offerController.readAndRetrieveQRCodeImage(qrCodeImagePath);
        return {
          filename,
          imageBuffer,
        };
      })
    );

    const validQRCodes = qrCodeImages.filter((item) => item.imageBuffer);

    if (validQRCodes.length > 0) {
      res.setHeader('Content-Type', 'image/png');
      res.json(validQRCodes);
    } else {
      res.status(404).send('No valid QR Code images found');
    }
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
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

