// controllers/offerController.js

const Offer = require('../models/Offer');
const { Op } = require('sequelize');
const Store = require('../models/store');
const Company = require('../models/company');
const Jimp = require('jimp');
const QRCode = require('qrcode');
const fs = require('fs');
const jsQR = require('jsqr');
const path = require('path');

exports.createOffer = async (req, res) => {
  try {
    console.log('req.user:', req.user);
    const { company_id } = req.user;
    const { ...offerData } = req.body;
    offerData.company_id = company_id;
    const offer = await Offer.create(offerData);
    const qrCodeData = `offer_id: ${offer.offer_id}\n` +
      `offer_name_arabic: ${offer.offer_name_arabic}\n` +
      `offer_name_english: ${offer.offer_name_english}\n` +
      `offer_description: ${offer.offer_description}\n` +
      `number_point: ${offer.number_point}\n` +
      `number_discount: ${offer.number_discount}\n` +
      `offer_start_date: ${offer.offer_start_date}\n` +
      `offer_end_date: ${offer.offer_end_date}\n` +
      `offer_discount: ${offer.offer_discount}\n` +
      `branch_id: ${offer.branch_id}\n` +
      `company_id: ${offer.company_id}\n`;

    const qrCodeDirectory = 'public/qrcodes';
    const qrCodeImagePath = path.join(qrCodeDirectory, `offer_${offer.offer_id}.png`);

    if (!fs.existsSync(qrCodeDirectory)) {
      fs.mkdirSync(qrCodeDirectory, { recursive: true });
    }

    await QRCode.toFile(qrCodeImagePath, qrCodeData, {
      width: 300,
      height: 300
    });

    offer.qrCodeImagePath = qrCodeImagePath;
    await offer.save();

    // Send success response
    return res.json(offer);
  } catch (error) {
    // Log the error
    console.error(error);
    
    // Send a generic error response
    return res.status(400).json({ error: 'Failed to create offer', details: 'An unexpected error occurred.' });
}

};



exports.readAndRetrieveQRCodeImage = async (qrCodeImagePath) => {
  try {
    const qrCodeImage = await Jimp.read(qrCodeImagePath);

  
    const qrCodeImageBuffer = await qrCodeImage.getBufferAsync(Jimp.MIME_PNG);

    return qrCodeImageBuffer;
  } catch (error) {
    console.error(`Error retrieving QR Code image from ${qrCodeImagePath}: ${error.message}`);
    return null;
  }
};
exports.readAndRetrieveQRCodeImagesMultiple = async (qrCodeImagePaths) => {
  try {
    const qrCodeImages = await Promise.all(qrCodeImagePaths.map(async (qrCodeImagePath) => {
      const qrCodeImage = await Jimp.read(qrCodeImagePath);
      const qrCodeImageBuffer = await qrCodeImage.getBufferAsync(Jimp.MIME_PNG);
      return qrCodeImageBuffer;
    }));

    return qrCodeImages;
  } catch (error) {
    console.error(`Error retrieving QR Code images: ${error.message}`);
    return null;
  }
};
exports.getAllQRCodeImages = (qrCodeDirectory) => {
  const files = fs.readdirSync(qrCodeDirectory);
  const qrCodeDataCollection = [];

  for (const file of files) {
    if (file.endsWith('.png')) {
      const qrCodeImagePath = path.join(qrCodeDirectory, file);
      const width = 300;
      const height = 300;

      const qrCodeData = {
        filename: file,
        data: this.readAndRetrieveQRCodeImage(qrCodeImagePath, width, height),
      };

      qrCodeDataCollection.push(qrCodeData);
    }
  }

  return qrCodeDataCollection;
};

exports.getAllOffers = async (req, res) => {
  try {
    const offers = await Offer.findAll();
    res.json(offers);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch Offers', details: error.message });
  }
};


exports.getOfferById = async (req, res) => {
  const offerId = req.params.id;

  try {
    const offer = await Offer.findByPk(offerId);
    if (!offer) {
      return res.status(404).json({ error: 'Offer not found' });
    }
    res.json(offer);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the offer', details: error.message });
  }
};

exports.updateOffer = async (req, res) => {
  const offerId = req.params.id;

  try {
    const [updated] = await Offer.update(req.body, {
      where: { offer_id: offerId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Offer not found or not updated' });
    }
    const updatedOffer = await Offer.findByPk(offerId);
    res.json(updatedOffer);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the offer', details: error.message });
  }
};

exports.deleteOffer = async (req, res) => {
  const offerId = req.params.id;

  try {
    const deleted = await Offer.destroy({
      where: { offer_id: offerId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'Offer not found or not deleted' });
    }
    res.json({ message: 'Offer deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the offer', details: error.message });
  }
};

exports.getFilteredOffers = async (req, res) => {
  try {
    const { filter } = req.query;
    let sortDirection = 'ASC';
    if (filter === 'new') {
      sortDirection = 'DESC'; 
    }
    const offers = await Offer.findAll({
      order: [['createdAt', sortDirection]],
    });
    res.json(offers);
  } catch (error) {
    console.error('Error retrieving and sorting offers:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.getStoresByOffer = async (req, res) => {
  const companyId = req.params.companyId;
  try {
    const companies = await Offer.findAll({
      where: { company_id: companyId },
        include: [
          { model: Company, as: 'companies' },
          
        ]
      });
      res.json(companies);
      return companies;
    } catch (error) {
      console.error('Error getting companies by offers:', error);
      throw error;
    }
  };
 