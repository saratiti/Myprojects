const { redeemPointsWithOfferDiscount } = require('../services/offer_redemption_service');
const Transaction = require('../models/transaction');
const Store = require('../models/store');
const Offer= require('../models/offer');
const pointController = require('./pointsController');
const Barcode=require('../models/barcode');
const Company=require('../models/company')
const Branche=require('../models/branche')


async function updateBarcodeStatus(barcodeValue, status) {
  try {
    const [updatedRows] = await Barcode.update(
      { barcode_status: status },
      {
        where: {
          barcode_value: barcodeValue,
        },
      }
    );

    if (updatedRows === 0) {
      console.error('Barcode not found or not updated:', barcodeValue);
    }
  } catch (error) {
    console.error('Error updating barcode status:', error);
    throw error;
  }
}

async function createTransactionRecord(userId, storeId, offerId, points, transactionType) {
  try {
    await Transaction.create({
      user_id: userId,
      store_id: storeId,
      offer_id: offerId,
      points,
      transaction_type: transactionType,
      transaction_date: new Date(),
    });
  } catch (error) {
    console.error('Error creating transaction record:', error);
    throw error;
  }
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





exports.redeemPoints = async (req, res) => {
  try {
    const { storeId, offerId, pointsRedeemed, scannedBarcode } = req.body;

    if (!storeId || !offerId || !pointsRedeemed || pointsRedeemed <= 0 || !scannedBarcode) {
      return res.status(400).json({ error: 'Invalid request parameters' });
    }

    console.log('User ID:', req.user.user_id);

    const userPoints = await pointController.getTotalPointsByUserId(req.user.user_id);

    if (userPoints === undefined) {
      return res.status(500).json({ error: 'Failed to retrieve user points' });
    }

    if (userPoints < pointsRedeemed) {
      return res.status(400).json({ error: 'Not enough points to redeem' });
    }

    const previousRedemption = await Transaction.findOne({
      where: {
        user_id: req.user.user_id,
        store_id: storeId,
        offer_id: offerId,
        transaction_type: 'redemption',
      },
    });

    if (previousRedemption) {
      return res.status(400).json({ error: 'User has already redeemed from this offer and store' });
    }

   
    const barcodeInfo = await getBarcodeInformation(scannedBarcode,offerId,storeId);

    if (!barcodeInfo) {
      return res.status(400).json({ error: 'Barcode information not found' });
    }

    
    console.log('Barcode Information:', barcodeInfo);


    try {
      const redemption = await redeemPointsWithOfferDiscount(storeId, offerId, pointsRedeemed, req.user.user_id);

      if (!redemption) {
        return res.status(400).json({ error: 'Redemption failed not enough points' });
      }

      await updateBarcodeStatus(scannedBarcode, 'redeemed');
      await createTransactionRecord(req.user.user_id, storeId, offerId, -pointsRedeemed, 'redemption');
      res.status(200).json({
        message: 'Points redeemed successfully',
        redeemedPoints: pointsRedeemed,
        redemption,
        barcodeInfo: barcodeInfo.toJSON(), 
      });
    } catch (redemptionError) {
      if (redemptionError.message === 'Not enough points to redeem') {
        return res.status(400).json({ error: 'Not enough points to redeem' });
      }
      console.error('Error redeeming points with offer discount:', redemptionError);
      res.status(500).json({ error: 'Internal server error' });
    }
  } catch (error) {
    console.error('Error in redeemPoints controller:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.getTotalRedeemedPoints = async (req, res) => {
  try {
    const userId = req.user ? req.user.user_id : req;

    if (req.user && !res) {
      console.error('Response object is undefined.');
      return;
    }

    const totalRedeemedPoints = await Transaction.sum('points', {
      where: {
        user_id: userId,
        transaction_type: 'redemption',
      },
    });
    res.json({ totalRedeemedPoints});
    return totalRedeemedPoints || 0;
  } catch (error) {
    console.error('Error getting total redeemed points:', error);
    throw error;
  }
};