// controllers/StoreController.js
const sequelize = require('../config/database');
const Store = require('../models/store');
const Type = require('../models/type');
const Offer = require('../models/offer');
const Company = require('../models/company');
const Branche = require('../models/branche');


exports.createStore = async (req, res) => {
  try {
    const store = await Store.create(req.body);
    res.json(store);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create Store', details: error.message });
  }
};


exports.getAllStores = async (req, res) => {
  try {
    const stores = await Store.findAll({
        include: [
          { model: Type, as: 'types' },
          { model: Company, as: 'companies' },
        ]
      });
    res.json(stores);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch Stores', details: error.message });
  }
};

exports.getStoreById = async (req, res) => {
  const storeId = req.params.id;

  try {
    const store = await Store.findByPk(storeId);
    if (!store) {
      return res.status(404).json({ error: 'Store not found' });
    }
    res.json(store);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the Store', details: error.message });
  }
};

exports.updateStore = async (req, res) => {
  const storeId = req.params.id;

  try {
    const [updated] = await Store.update(req.body, {
      where: { store_id: StoreId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Store not found or not updated' });
    }
    const updatedStore = await Store.findByPk(storeId);
    res.json(updatedStore);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the Store', details: error.message });
  }
};

exports.deleteStore = async (req, res) => {
  const storeId = req.params.id;

  try {
    const deleted = await Store.destroy({
      where: { store_id: storeId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'Store not found or not deleted' });
    }
    res.json({ message: 'Store deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the Store', details: error.message });
  }
};



// exports.getTypeAndOffersByType = async (req, res) => {
//   const typeId = req.params.typeId;

//   try {
//     const stores = await Store.findAll({
//       where: { type_id: typeId },
//       include: [
//         {
//           model: Type,
//           as: 'types',
//         },
//         {
//           model: Offer,
//           as: 'offers',
//           include: [
//             {
//               model: Company,
//               where: { company_id: sequelize.col('offers.company_id') },
//               attributes: ['company_name'],
//               as: 'companies',
//             },
//           ],
//         },
//       ],
//     });

//     if (!stores || stores.length === 0) {
//       return res.status(404).json({ error: 'No stores found for the given type' });
//     }

//     res.json(stores);
//   } catch (error) {
//     console.error('Error getting type and offers by type:', error);
//     res.status(500).json({ error: 'Failed to fetch type and offers by type', details: error.message });
//   }
// };


exports.getOffersWithStoresAndType = async (req, res) => {
  const typeId = req.params.typeId;

  try {
 
    const storesWithType = await Store.findAll({
      include: [
        {
          model: Type,
          as: 'types',
          where: {
            type_id: typeId,
          },
        },
      ],
    });

    if (!storesWithType || storesWithType.length === 0) {
      console.log('No stores found for the specified type');
      return res.status(404).json({ error: 'No stores found for the specified type' });
    }

   
    const storeIds = storesWithType.map(store => store.store_id);

    
    const offersWithStoresAndType = await Offer.findAll({
      include: [
        {
          model: Store,
          as: 'stores',
          where: {
            store_id: storeIds,
          },
        },
      ],
    });

    const formattedData = offersWithStoresAndType.map(offer => {
      return {
        offer: offer.toJSON(),
        store: offer.store ? offer.store.toJSON() : null,
      };
    });

    console.log('Offers with stores of specific type:', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};




exports.getAllStoresWithOffers = async (req, res) => {
  try {
    const stores = await Offer.findAll({
      include: [
      
        {
          model: Store,
          as: 'stores',
          include: [
            {
              model: Company,
              where: { company_id: sequelize.col('stores.company_id') },
              attributes: ['company_name'],
              as: 'companies',
            },
          ],
        },
      ],
    });

    if (!stores || stores.length === 0) {
      return res.status(404).json({ error: 'No stores found with offers and companies' });
    }

    res.json(stores);
  } catch (error) {
    console.error('Error getting all stores with offers and companies:', error);
    res.status(500).json({ error: 'Failed to fetch all stores with offers and companies', details: error.message });
  }
};

exports.getOfferByStoreAndOfferId = async (req, res) => {
  const storeId = req.params.storeId;
  const offerId = req.params.offerId;

  try {
    const offer = await Offer.findOne({
      where: {
        offer_id: offerId,
      },
      include: [
        {
          model: Store,
          as: 'stores',
          where: {
            store_id: storeId,
          },
        },
      ],
    });

    if (!offer) {
      console.log('Offer not found');
      return res.status(404).json({ error: 'Offer not found' });
    }

    const store = offer.stores && offer.stores.length > 0 ? offer.stores[0].toJSON() : null;

    const formattedData = {
      offer: offer.toJSON(),
      store: store,
    };

    console.log('Offer with associated store for store ID', storeId, 'and offer ID', offerId, ':', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};