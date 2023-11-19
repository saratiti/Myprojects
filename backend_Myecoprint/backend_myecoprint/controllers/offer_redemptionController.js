
const { redeemPointsWithOfferDiscount } = require('../services/offer_redemption_service');

exports.redeemPoints = async (req, res) => {
  try {
      const { storeId, offerId, pointsRedeemed } = req.body;

      if (!storeId || !offerId || !pointsRedeemed || pointsRedeemed <= 0) {
          return res.status(400).json({ error: 'Invalid request parameters' });
      }

      console.log('User ID:', req.user_id); // Log the user ID here

      const redemption = await redeemPointsWithOfferDiscount(storeId, offerId, pointsRedeemed, req.user_id);

      res.status(200).json({ message: 'Points redeemed successfully', redemption });
  } catch (error) {
      console.error('Error in redeemPoints controller:', error);
      res.status(500).json({ error: 'Internal server error' });
  }
};

