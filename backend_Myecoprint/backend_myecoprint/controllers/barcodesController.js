
const Barcode = require('../models/barcode');
const Branche = require('../models/branche');
const Offer = require('../models/offer');
const Store = require('../models/store');
const User = require('../models/user');
const Point=require('../models/point');
const qrcode = require('qrcode');
const uuid = require('uuid');

const { promisify } = require('util');
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

  // Check if offer_id and store_id are provided
  if (!offerId || !storeId) {
    return res.status(400).json({ message: 'Both offer_id and store_id are required in the request body' });
  }

  try {
    const matchingBarcodeExists = await Barcode.findOne({
      where: { offer_id: offerId, store_id: storeId },
      attributes: ['barcode_id'], // Only retrieve barcode_id to check for existence
    });

    // Check if matching barcode exists
    if (!matchingBarcodeExists) {
      return res.status(404).json({ message: 'Barcode not found' });
    }

    // If the execution reaches here, it means there is a matching barcode
    res.json({ message: 'Matching barcode found' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};


exports.generateBarcode = async (req, res) => {
  try {
    const { store_id, offer_id, branch_id} = req.body;
    const barcodeValue = uuidv4();
    const newBarcode = await Barcode.create({
      store_id,
      offer_id,
      barcode_value: barcodeValue,
      barcode_status: 'active',
      branch_id,
      barcode_date: new Date(),
    });

    qrcode.toDataURL(barcodeValue, (err, qrCodeData) => {
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

// exports.collectPointsFromBarcode = async (req, res) => {
//   try {
//     const { barcodeValue, userId } = req.body;

    
//     const barcode = await Barcode.findOne({ barcode_value: barcodeValue });

//     if (!barcode) {
//       return res.status(404).json({ message: 'Barcode not found' });
//     }

//     if (barcode.points_collected) {
//       return res.status(400).json({ message: 'Points already collected for this barcode' });
//     }

//     const user = await User.findOneAndUpdate(
//       { _id: userId },
//       { $inc: { points: barcode.points_to_collect } },
//       { new: true }
//     );

//     // Mark the barcode as points collected
//     barcode.points_collected = true;
//     await barcode.save();

//     res.json({ success: true, totalPoints: user.points });
//   } catch (error) {
//     console.error('Error collecting points:', error);
//     res.status(500).json({ message: 'Error collecting points' });
//   }
// };



function generateRandomString(length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
}



function generateRandomString(length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
}

exports.generateBarcodeOfferStore = async (req, res) => {
  try {
    const { storeId, offerId } = req.body;
    const userId = req.user.user_id;

    const offer = await Offer.findByPk(offerId);

    if (!offer) {
      console.error('Offer not found for the given offer_id:', offerId);
      return res.status(404).json({ message: 'Offer not found' });
    }

    const currentNumberPoint = offer.number_point;
    const randomString = generateRandomString(12);
    const barcodeValue = `#${randomString}`;

    // Generate QR code data as a buffer
    const qrCodeBuffer = await qrcode.toBuffer(barcodeValue);

    const newBarcode = await Barcode.create({
      store_id: storeId,
      offer_id: offerId,
      barcode_value: barcodeValue,
      barcode_status: 'active',
      barcode_date: new Date(),
      number_point: currentNumberPoint,
      user_id: userId,
    });

    res.writeHead(200, {
      'Content-Type': 'image/png',
      'Content-Disposition': `inline; filename="${barcodeValue}.png"`,
      'Content-Length': qrCodeBuffer.length,
    });

    res.end(qrCodeBuffer);

    console.log('Barcode and QR code generated successfully');
  } catch (error) {
    console.error('Error generating barcode and QR code:', error);
    res.status(500).json({ message: 'Error generating barcode and QR code' });
  }
};