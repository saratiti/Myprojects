
const Barcode = require('../models/barcode');
const Branche = require('../models/branche');
const Offer = require('../models/offer');
const Store = require('../models/store');
const User = require('../models/user');
const jimp = require('jimp');
const Point=require('../models/point');
const qrcode = require('qrcode');

const path = require('path');

const fs = require('fs');
exports.createBarcode = async (req, res) => {
  try {
    const barcode = await Barcode.create(req.body);
    res.json(barcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create barcode', details: error.message });
  }
};

exports.getAllBarcodes = async (req, res) => {
  try {
    const barcodes = await Barcode.findAll({
      include: [
        { model: Store, as: 'stores' },
        { model: Offer, as: 'offers' },
        { model: Branche, as: 'branches' },
        { model: User, as: 'users' }
      ]
    });
  
    if (barcodes.length === 0) {
      console.log('No records found.');
    }
  
    res.json(barcodes);
  } catch (error) {
    console.error('Error:', error);
    res.status(400).json({ error: 'Failed to fetch barcode', details: error.message });
  }
};  

exports.getBarcodeById = async (req, res) => {
  const barcodeId = req.params.id;

  try {
    const barcode = await Barcode.findByPk(barcodeId);
    if (!barcode) {
      return res.status(404).json({ error: 'Barcode not found' });
    }
    res.json(barcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the barcode', details: error.message });
  }
};

exports.updateBarcode = async (req, res) => {
  const barcodeId = req.params.id;

  try {
    const [updated] = await Barcode.update(req.body, {
      where: { barcode_id: barcodeId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Barcode not found or not updated' });
    }
    const updatedBarcode = await Barcode.findByPk(barcodeId );
    res.json(updatedBarcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the barcode', details: error.message });
  }
};

exports.deleteBarcode = async (req, res) => {
  const barcodeId = req.params.id;

  try {
    const deleted = await Barcode.destroy({
      where: { barcode_id: barcodeId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'Barcode not found or not deleted' });
    }
    res.json({ message: 'Barcode deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the barcode', details: error.message });
  }
};



exports.scanBarcode = async (req, res) => {
  const { barcode_value, branch_id, store_id, user_id, totalPrice, offer_id } = req.body;

  if (typeof barcode_value === 'undefined') {
    return res.status(400).json({ message: 'Invalid request: barcode_value is missing.' });
  }
  try {
    const barcode = await Barcode.findOne({
      where: { barcode_value, branch_id, store_id, user_id, offer_id },
    });

    if (!barcode) {
      return res.status(404).json({ message: "Barcode not found." });

    }
    const branch = await Branche.findByPk(branch_id);
    const store = await Store.findByPk(store_id);

    if (!branch || !store) {
      return res.status(404).json({ message: 'Branch or store not found.' });
    }
    if (typeof barcode.offer_id === 'undefined') {
      return res.status(404).json({ message: 'Barcode does not have a valid offer.' });
    }
    const offer = await Offer.findByPk(barcode.offer_id);

    if (!offer) {
      return res.status(404).json({ message: 'Offer not found.' });
    }
  

const userPoints = await Point.findOne({
  where: { store_id, user_id },
});

if (!userPoints || userPoints.total_points < offer.number_point) {
  return res.status(400).json({ message: 'Insufficient points to redeem this offer.' });
}
console.log('Searching for barcode with values:');
console.log('barcode_value:', barcode_value);
console.log('branch_id:', branch_id);
console.log('store_id:', store_id);
console.log('user_id:', user_id);
const discount = (offer.offer_discount / 100) * totalPrice;
const discountedPrice = totalPrice - discount;
userPoints.total_points -= offer.number_point;
await userPoints.save();

res.status(200).json({
  message: 'Offer applied successfully',
  barcode_id: barcode.barcode_id,
  discountedPrice,
  remainingPoints: userPoints.total_points,
});

   
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.checkBarcode = async (req, res) => {
  const offerId = req.body.offer_id;
  const storeId = req.body.store_id;
  if (!offerId || !storeId) {
    return res.status(400).json({ message: 'Both offer_id and store_id are required in the request body' });
  }

  try {
    const matchingBarcodeExists = await Barcode.findOne({
      where: { offer_id: offerId, store_id: storeId },
      attributes: ['barcode_id'],  
    });

   
    
    if (!matchingBarcodeExists) {
      return res.status(404).json({ message: 'Barcode not found' });
    }

   
    
    res.json({ message: 'Matching barcode found' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};


exports.generateBarcode = async (req, res) => {
  try {
    const { store_id, number_point } = req.body;

    const newOffer = await Offer.create({
      number_point,
    });

    const storeDetails = await Store.findByPk(store_id);

    if (!storeDetails) {
      return res.status(404).json({ message: 'Store not found' });
    }

    const barcodeValue = '#' + generateRandomString(11); 

    const barcodeData = {
      store_id,
      offer_id: newOffer.offer_id,
      number_point,
    };

    const newBarcode = await Barcode.create({
      store_id,
      offer_id: newOffer.offer_id,
      barcode_value: barcodeValue,
      barcode_status: 'active',
      number_point,
      barcode_date: new Date(),
    });

    qrcode.toDataURL(barcodeValue, barcodeData, (err, qrCodeData) => {
      if (err) {
        res.status(500).send('Error generating QR code');
      } else {
        res.setHeader('Content-Type', 'image/png');
        res.setHeader('Content-Disposition', 'attachment; filename="qr-code.png"');
        const dataUri = `data:image/png;base64,${qrCodeData.split(',')[1]}`;
        const imageBuffer = Buffer.from(dataUri.split(',')[1], 'base64');
        res.setHeader('Content-Length', imageBuffer.length);
        res.send(imageBuffer);
      }
    });
  } catch (error) {
    console.error('Error generating barcode and QR code:', error);
    res.status(500).json({ message: 'Error generating barcode and QR code' });
  }
};


function generateRandomString(length) {
  let result = '';
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}
exports.collectPointsFromBarcode = async (req, res) => {
  try {
    const { barcodeValue } = req.body;
    const userId = req.user.user_id;

    if (!userId) {
      return res.status(400).json({ error: 'User not found' });
    }

    const barcode = await Barcode.findOne({
      where: { barcode_value: barcodeValue, barcode_status: 'active' }, 
      
      include: [{ model: Offer, as: 'offers' }],
    });

    if (!barcode) {
      return res.status(400).json({ error: 'Barcode not found or invalid' });
    }

    await Point.create({
      user_id: userId,
      total_points: barcode.offers.number_point,
    });

    const user = await User.findByPk(userId);
    await Point.increment('total_points', {
      by: barcode.offers.number_point,
      where: { user_id: userId },
    });

    res.status(200).json({
      message: 'Points collected successfully',
      collectedPoints: barcode.offers.number_point,
    });
  } catch (error) {
    console.error('Error in collectPointsFromBarcode endpoint:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};



function generateRandomString(length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
}
async function getBarcodeInformation(scannedBarcode, offerId, storeId) {
  try {
    const barcodeInfo = await Barcode.findOne({
      where: {
        barcode_value: scannedBarcode,
      },
      include: [
        { model: Offer, as: 'offers', where: { offer_id: offerId } },
        { model: Store, as: 'stores', where: { store_id: storeId } },
      ],
    });

    if (!barcodeInfo) {
      console.error('Barcode information not found:', scannedBarcode);
      return null;
    }

    return barcodeInfo;
  } catch (error) {
    console.error('Error retrieving barcode information:', error);
    throw error;
  }
}
xports.generateBarcodeOfferStore = async (req, res) => {
  try {
    const { storeId, offerId } = req.body;
    const user = req.user;
    const userId = user.user_id;
    if (!storeId || !offerId) {
      return res.status(400).json({ message: 'Store ID and offer ID are required' });
    }

   
    const existingBarcode = await Barcode.findOne({
      where: {
        store_id: storeId,
        offer_id: offerId,
        user_id: user.user_id,
      },
    });

    if (existingBarcode && existingBarcode.image_path) {
    
      console.log('Barcode already exists for the user and offer');
      const imagePath = existingBarcode.image_path;
      const imageStream = fs.createReadStream(imagePath);
      return imageStream.pipe(res);
    }

   
    const barcodeImagePath = path.join(__dirname, '../barcode_images', `${storeId}_${offerId}_${user.user_id}.png`);

    if (fs.existsSync(barcodeImagePath)) {
     
      console.log('Barcode image already exists');
      const imageStream = fs.createReadStream(barcodeImagePath);
      imageStream.pipe(res);
      return;
    }

   
    const offer = await Offer.findByPk(offerId);

    if (!offer) {
      console.error('Offer not found for the given offer_id:', offerId);
      return res.status(404).json({ message: 'Offer not found' });
    }

    
    const store = await Store.findByPk(storeId);

    if (!store) {
      console.error('Store not found for the given store_id:', storeId);
      return res.status(404).json({ message: 'Store not found' });
    }

    const currentNumberPoint = offer.number_point;
    const randomString = generateRandomString(12);

    const barcodeValue = `#${randomString}#${storeId}#${offerId}#${currentNumberPoint}#${userId}`;

  
    const qrCodeBuffer = await qrcode.toBuffer(barcodeValue);

    if (!qrCodeBuffer) {
      console.error('Failed to generate QR code buffer');
      return res.status(500).json({ message: 'Failed to generate QR code buffer' });
    }

  
    const imageDirectory = path.join(__dirname, '../barcode_images');
    fs.mkdirSync(imageDirectory, { recursive: true });

    // Write QR code buffer to file system
    fs.writeFileSync(barcodeImagePath, qrCodeBuffer);

    // Load the barcode image using jimp
    const barcodeImage = await jimp.read(barcodeImagePath);

  
    barcodeImage.scan(0, 0, barcodeImage.bitmap.width, barcodeImage.bitmap.height, (x, y, idx) => {
      const red = barcodeImage.bitmap.data[idx];
      const green = barcodeImage.bitmap.data[idx + 1];
      const blue = barcodeImage.bitmap.data[idx + 2];

    
      if (red === 0 && green === 0 && blue === 0) {
        barcodeImage.setPixelColor(jimp.cssColorToHex('#99CA3C'), x, y); // Light green for black
      }
    });

   
    await barcodeImage.writeAsync(barcodeImagePath);

  
    const newBarcode = await Barcode.create({
      store_id: storeId,
      offer_id: offerId,
      barcode_value: barcodeValue,
      barcode_status: 'active',
      barcode_date: new Date(),
      number_point: currentNumberPoint,
      user_id: user.user_id,
      image_path: barcodeImagePath,
    });

  
    const imageStream = fs.createReadStream(barcodeImagePath);
    imageStream.pipe(res);

    console.log('New barcode and QR code generated successfully');
  } catch (error) {
    console.error('Error generating barcode and QR code:', error);
    res.status(500).json({ message: 'Error generating barcode and QR code' });
  }
};

exports.getBarcodeByStoreAndOfferId = async (req, res) => {
  const storeId = req.params.storeId;
  const offerId = req.params.offerId;
  const user = req.user;
  try {
    const barcode = await Barcode.findOne({
      where: {
        offer_id: offerId,
        store_id: storeId,
        user_id: user.user_id,
      },
      include: [
        { model: Store, as: 'stores' },
        { model: Offer, as: 'offers' }
      ]
    });

    if (!barcode) {
      console.log('Barcode not found');
      return res.status(404).json({ error: 'Barcode not found' });
    }

    const store = barcode.stores && barcode.stores.length > 0 ? barcode.stores[0].toJSON() : null;
    const offer = barcode.offers && barcode.offers.length > 0 ? barcode.offers[0].toJSON() : null;
    
    const barcodeStatus = barcode.barcode_status;

    const formattedData = {
      barcode: barcode.toJSON(),
      store: store,
      offer: offer,
      barcode_status: barcodeStatus
    };

    console.log('Barcode with associated store and offer for store ID', storeId, 'and offer ID', offerId, ':', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};



