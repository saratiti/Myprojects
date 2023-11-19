
const offerModel=require('../models/user');
const storeModel=require('../models/store');
const barcodeModel=require('../models/barcode');


exports.checkIfOfferAddedByAdmin = async (storeId, offerId) => {
  try {
    const store = await storeModel.findByPk(storeId, {
      include: [
        {
          model: offerModel,
          where: { offer_id: offerId },
        },
      ],
    });

    return store !== null;
  } catch (error) {
    throw error;
  }
};

exports.validateBarcode = (barcodeData) => {

  return barcodeData.length === 12;
};

exports.calculateDiscount = (offer, originalPrice) => {

  const discountPercentage = offer.offer_discount / 100;
  const discountAmount = originalPrice * discountPercentage;
  return discountAmount;
};

exports.findOfferId = async (barcodeData) => {
  try {
    const barcode = await barcodeModel.findOne({
      where: {
        barcode_value: barcodeData,
      },
    });

    if (barcode) {
      const offer = await offerModel.findByPk(barcode.offer_id);
      if (offer) {
        return offer.id;
      }
    }

    return null;
  } catch (error) {
    console.error('Error finding offer ID:', error);
    throw error;
  }
};
