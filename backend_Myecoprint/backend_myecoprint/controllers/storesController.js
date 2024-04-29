// controllers/StoreController.js
const sequelize = require('../config/database');
const Store = require('../models/store');
const Type = require('../models/type');
const Offer = require('../models/offer');
const Company = require('../models/company');
const companyController=require('./companiesController')
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
      where: { store_id: storeId },
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
      include: [{
        model: Type,
        as: 'types',
        where: { type_id: typeId },
      }],
    });


    if (!storesWithType || storesWithType.length === 0) {
      console.log('No stores found for the specified type');
      return res.status(404).json({ error: 'No stores found for the specified type' });
    }
    const storeIds = storesWithType.map(store => store.store_id);

   
    const offersWithStoresAndType = await Offer.findAll({
      include: [{
        model: Store,
        as: 'stores',
        where: { store_id: storeIds },
      }, {
        model: Company, 
        
        as: 'companies', 
      }],order: [['createdAt', 'DESC']], 
    });
    

    
    const formattedData = await Promise.all(offersWithStoresAndType.map(async offer => {
      const store = offer.store ? offer.store.toJSON() : null;
      let companyDetails = null; 
      if (store && store.company_id) {
        try {
         
          companyDetails = await Company.findByPk(store.company_id);
          if (companyDetails) {
           
            companyDetails = companyDetails.toJSON();
          }
        } catch (error) {
          console.error('Error fetching company details:', error);
        }
      }
      return {
        offer: offer.toJSON(),
        store: store,
        companyDetails: companyDetails
      };
    }));

    console.log('Offers with stores of specific type:', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};

exports.getAllStoresWithOffers = async (req, res) => {
  try {
    const storesWithType = await Store.findAll({
      include: [{
        model: Type,
        as: 'types',
      }],
    });

    if (!storesWithType || storesWithType.length === 0) {
      console.log('No stores found for the specified type');
      return res.status(404).json({ error: 'No stores found for the specified type' });
    }

    const storeIds = storesWithType.map(store => store.store_id);


    const offersWithStoresAndType = await Offer.findAll({
      include: [{
        model: Store,
        as: 'stores',
        where: { store_id: storeIds },
      }, {
        model: Company,
        as: 'companies',
      }],
      order: [['createdAt', 'DESC']],
    });

    const formattedData = await Promise.all(offersWithStoresAndType.map(async offer => {
      const store = offer.store ? offer.store.toJSON() : null;
      let companyDetails = null;
      if (store && store.company_id) {
        try {
          companyDetails = await Company.findByPk(store.company_id);
          if (companyDetails) {
            companyDetails = companyDetails.toJSON();
          }
        } catch (error) {
          console.error('Error fetching company details:', error);
        }
      }
      return {
        offer: offer.toJSON(),
        store: store,
        companyDetails: companyDetails
      };
    }));

    console.log('Offers with stores of specific offer:', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
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
          include: [
            {
              model: Company,
              where: { company_id: sequelize.col('stores.company_id') },
              as: 'companies',
            },
          ],
        },
      ],
    });

    if (!offer) {
      console.log('Offer not found');
      return res.status(404).json({ error: 'Offer not found' });
    }

    const store = offer.stores && offer.stores.length > 0 ? offer.stores[0].toJSON() : null;
    const company = store && store.companies && store.companies.length > 0 ? store.companies[0].toJSON() : null;

    // If company exists and has an image, retrieve the image
    if (company && company.company_id) {
      const imageUrl = await companyController.getCompanyImage(company.company_id);
      company.image = imageUrl; // Assign the image URL to the company object
    }

    const formattedData = {
      offer: offer.toJSON(),
      store: store,
      company: company,
    };

    console.log('Offer with associated store and company for store ID', storeId, 'and offer ID', offerId, ':', formattedData);
    return res.status(200).json({ data: formattedData });
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};
exports.getAllStoresByCompanyId = async (req, res) => {
  const companyId = req.params.companyId; 

  try {
    const stores = await Store.findAll({
      where: { company_id: companyId }, 
      include: [
        { model: Type, as: 'types' },
        { model: Company, as: 'companies' },
      ]
    });

    if (!stores || stores.length === 0) {
      return res.status(404).json({ error: 'No stores found for the specified company' });
    }

    res.json(stores);
  } catch (error) {
    console.error('Error getting all stores by company_id:', error);
    res.status(500).json({ error: 'Failed to fetch stores by company_id', details: error.message });
  }
};