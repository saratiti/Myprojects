const Offer = require('../models/offer');
const Point = require('../models/point');
const PointRedemption = require('../models/point_redemption');

const calculateDiscountedPointsForOffer = async (offerId, pointsRedeemed) => {
  try {
    const offer = await Offer.findByPk(offerId);

    if (!offer) {
      throw new Error('Offer not found.');
    }
    const discountedPoints = Math.round((pointsRedeemed / offer.number_point) * offer.number_discount);
    return discountedPoints;
  } catch (error) {
    console.error('Error calculating discounted points for offer:', error);
    throw error;
  }
};

const updateTotalPoints = async (pointsToUpdate) => {
  try {
    const pointRecord = await Point.findOne({
      
    });
    if (!pointRecord) {
      throw new Error('Point record not found for the user.');
    }
    const updatedTotalPoints = pointRecord.total_points + pointsToUpdate;
    await pointRecord.update({ total_points: updatedTotalPoints });
    return updatedTotalPoints;
  } catch (error) {
    console.error('Error updating total points:', error);
    throw error;
  }
};
const createPointRedemption = async (storeId, offerId, pointsRedeemed, userId) => {
  try {
      console.log('User ID in createPointRedemption:', userId); // Log the user ID here
      const redemption = await PointRedemption.create({
          store_id: storeId,
          offer_id: offerId,
          points_redeemed: pointsRedeemed,
          redemption_date: new Date(),
          user_id: userId,
      });
      return redemption;
  } catch (error) {
      console.error('Error creating point redemption:', error);
      throw error;
  }
};


exports.redeemPointsWithOfferDiscount = async (storeId, offerId, pointsRedeemed, userId) => {
  try {
      const discountedPoints = await calculateDiscountedPointsForOffer(offerId, pointsRedeemed);
      const redemption = await createPointRedemption(storeId, offerId, discountedPoints, userId);
      await updateTotalPoints(discountedPoints * -1, userId);
      return redemption;
  } catch (error) {
      console.error('Error redeeming points with offer discount:', error);
      throw error;
  }
};