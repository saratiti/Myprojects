const { redeemPointsWithOfferDiscount } = require('../services/offer_redemption_service');
const Transaction = require('../models/transaction');
const User = require('../models/user');
const Point = require('../models/point');
const pointController = require('./pointsController');

// exports.redeemPoints = async (req, res) => {
//   try {
//     const { storeId, offerId, pointsRedeemed } = req.body;

//     if (!storeId || !offerId || !pointsRedeemed || pointsRedeemed <= 0) {
//       return res.status(400).json({ error: 'Invalid request parameters' });
//     }

//     console.log('User ID:', req.user_id);

//     const userPoints = pointController.getTotalPointsByUserId(req.user_id);
//     console.log('User Points:', userPoints); // Add this log

//     if (userPoints < pointsRedeemed) {
//       return res.status(400).json({ error: 'Insufficient points for redemption' });
//     }

//     const redemption = await redeemPointsWithOfferDiscount(storeId, offerId, pointsRedeemed, req.user_id);

//     await Transaction.create({
//       user_id: req.user_id,
//       store_id: storeId,
//       offer_id: offerId,
//       points: -pointsRedeemed,
//       transaction_type: 'redemption',
//       transaction_date: new Date(),
//     });

//     res.status(200).json({ message: 'Points redeemed successfully', redemption });
//   } catch (error) {
//     console.error('Error in redeemPoints controller:', error);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// };
exports.redeemPoints = async (req, res) => {
  try {
    const { storeId, offerId, pointsRedeemed } = req.body;

    if (!storeId || !offerId || !pointsRedeemed || pointsRedeemed <= 0) {
      return res.status(400).json({ error: 'Invalid request parameters' });
    }

    console.log('User ID:', req.user_id);

    const userPoints = await pointController.getTotalPointsByUserId(req.user_id);
    console.log('User Points:', userPoints);

    if (userPoints < pointsRedeemed) {
      return res.status(400).json({ error: 'Not enough points to redeem' });
    }

 
    const redemption = await redeemPointsWithOfferDiscount(storeId, offerId, pointsRedeemed, req.user_id);

    if (!redemption) {
  
      return res.status(400).json({ error: 'Redemption failed not enough points' });
    }

    // Create a transaction record
    await Transaction.create({
      user_id: req.user_id,
      store_id: storeId,
      offer_id: offerId,
      points: -pointsRedeemed,
      transaction_type: 'redemption',
      transaction_date: new Date(),
    });

    res.status(200).json({ message: 'Points redeemed successfully', redemption });
  }  catch (error) {
    console.error('Error in redeemPoints controller:', error);
  
    if (error.message === 'Not enough points to redeem') {
      return res.status(400).json({ error: 'Not enough points to redeem' });
    }
    return res.status(500).json({ error: 'Internal server error' });
  }
  
};