
const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');


router.get('/', productController.getAllProducts);

router.post('/', productController.createProduct);
router.get('/category/:categoryId', productController.getProductsByCategory);
module.exports = router;
