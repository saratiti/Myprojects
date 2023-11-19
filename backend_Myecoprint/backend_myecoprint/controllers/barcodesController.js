
const Barcode = require('../models/barcode');
const Branche = require('../models/branche');
const Offer = require('../models/offer');
const Store = require('../models/store');
const User = require('../models/user');
const Point=require('../models/point');
const qrcode = require('qrcode');

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
  const barcodeValue = req.body.barcodeValue;
  const userId = req.user_id; 
  try {
    const barcode = await Barcode.findOne({
      where: { barcode_value: barcodeValue },
      include: [
        { model: Offer, as: 'offers' },
        { model: Store, as: 'stores' },
        { model: Branche, as: 'branches' },
      ],
    });
    if (!barcode) {
      return res.status(404).json({ message: 'Barcode not found' });
    }
    const offer = await Offer.findByPk(barcode.offer_id);
    const store = await Store.findByPk(barcode.store_id);
    const branch = await Branche.findByPk(barcode.branch_id);
    if (!offer || !store || !branch) {
      return res.status(403).json({ message: 'Barcode does not match your offer, store, or branch' });
    }
    const response = {
      barcode: {
        barcode_value: barcode.barcode_value, 
      },
      offer: {
        offer_id: offer.offer_id,
        offer_name_arabic: offer.offer_name_arabic,
        offer_name_english: offer.offer_name_english,
      },
      store: {
        store_id: store.store_id,
        name_arabic: store.name_arabic,
        name_english: store.name_english,
      },
      branch: {
        branch_id: branch.branch_id,
        email: branch.email,
        password: branch.password,
      },
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.generateBarcode = async (req, res) => {
  try {
    const dataToEncode = '98763432'; 
    
    const newBarcode = await Barcode.create({
      store_id: 4, 
      offer_id: 42,
      barcode_value: dataToEncode,
      barcode_status: 'active',
      branch_id: 3,
     // user_id: 6, 
      barcode_date: new Date(), 
    });

    qrcode.toDataURL(dataToEncode, (err, qrCodeData) => {
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
