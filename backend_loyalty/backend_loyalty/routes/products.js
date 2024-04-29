
const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');


router.get('/', productController.getAllProducts);

router.post('/', productController.createProduct);
router.get('/:id', productController.getProductsByCategory);
module.exports = router;
