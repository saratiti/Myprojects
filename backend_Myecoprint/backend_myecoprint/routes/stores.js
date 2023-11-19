const express = require('express');
const router = express.Router();
const storeController = require('../controllers/storesController');

router.post('/', storeController.createStore);
router.get('/', storeController.getAllStores);

router.get('/stores/:id', storeController.getStoreById);
router.put('/stores/:id', storeController.updateStore);
router.delete('/:id', storeController.deleteStore);
router.get('/type/:typeId', storeController.getTypeAndOffersByType);
router.get('/typeByoffer', storeController.getAllStoresWithOffers);

module.exports = router;


