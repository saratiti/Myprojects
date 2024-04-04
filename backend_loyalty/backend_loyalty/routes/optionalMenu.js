

const express = require('express');
const router = express.Router();
const optionalMenuController = require('../controllers/optionalMenuController');


router.get('/', optionalMenuController.getAllOptionalMenus);
router.get('/:productId',optionalMenuController.getOptionalMenuByProductId);

router.post('/', optionalMenuController.createOptionalMenu);

module.exports = router;
