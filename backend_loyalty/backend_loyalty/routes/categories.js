
const express = require('express');
const router = express.Router();
const categoryController = require('../controllers/categoryController');


router.get('/', categoryController.getAllCategories);


router.post('/categories', categoryController.createCategory);


router.put('/categories/:id', categoryController.updateCategory);
router.get('/image',categoryController.getCategoryImages);

router.delete('/categories/:id', categoryController.deleteCategory);

module.exports = router;
