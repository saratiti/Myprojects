const express = require('express');
const router = express.Router();
const storeController = require('../controllers/storesController');
const { authenticateToken } = require('../middleware/authMiddleware');
router.post('/', storeController.createStore);
router.get('/', storeController.getAllStores);

router.get('/stores/:id', storeController.getStoreById);
router.put('/stores/:id', storeController.updateStore);
router.delete('/:id', storeController.deleteStore);
router.get('/type/:typeId', storeController.getOffersWithStoresAndType);
router.get('/typeByoffer', storeController.getAllStoresWithOffers);
router.get('/:storeId/:offerId', storeController.getOfferByStoreAndOfferId);
router.get('/:companyId',authenticateToken, storeController.getAllStoresByCompanyId);
module.exports = router;


