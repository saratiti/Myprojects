

const express = require('express');
const router = express.Router();
const optionalMenuController = require('../controllers/optionalMenuController');


router.get('/:productId', optionalMenuController.getAllOptionalMenus);
router.get('/',optionalMenuController.getOptionalMenuByProductId);

router.post('/', optionalMenuController.createOptionalMenu);

module.exports = router;
