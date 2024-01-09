const Offer = require('../models/offer');
const Point = require('../models/point');
const PointRedemption = require('../models/point_redemption');
const PointController=require('../controllers/pointsController');


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

const updateTotalPoints = async (pointsToUpdate, userId) => {
  try {
    let pointRecord = await Point.findOne({
      where: {
        user_id: userId,
      },
    });

    if (!pointRecord) {
      pointRecord = await Point.create({
        user_id: userId,
        total_points: 0,
      });
    }
    const updatedTotalPoints = pointRecord.total_points + pointsToUpdate;
    const finalTotalPoints = Math.max(updatedTotalPoints, 0);
    await pointRecord.update({ total_points: finalTotalPoints });
    return finalTotalPoints;
  } catch (error) {
    console.error('Error updating total points:', error);
    throw error;
  }
};

const createPointRedemption = async (storeId, offerId, pointsRedeemed, userId) => {
  try {
    console.log('User ID in createPointRedemption:', userId);
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
    console.log('Redeem Points With Offer Discount - Start');

    const offer = await Offer.findByPk(offerId);

    if (!offer) {
      throw new Error('Offer not found.');
    }

    const discountedPoints = Math.round((pointsRedeemed / offer.number_point) * offer.number_discount);

    const userPoints = await PointController.getTotalPointsByUserId(userId);

    if (userPoints < discountedPoints) {
      throw new Error('Not enough points to redeem');
    }

    const redemption = await createPointRedemption(storeId, offerId, discountedPoints, userId);
    console.log('Redemption:', redemption);
    await updateTotalPoints(discountedPoints * -1, userId);
    console.log('Total Points Updated');

    console.log('Redeem Points With Offer Discount - End');
    return redemption;
  } catch (error) {
    console.error('Error redeeming points with offer discount:', error);
    throw error;
  }
};
