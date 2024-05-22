
const express = require('express');
const router = express.Router();
const categoryController = require('../controllers/categoryController');


router.get('/', categoryController.getAllCategories);


router.post('/categories', categoryController.createCategory);


router.put('/categories/:id', categoryController.updateCategory);
router.get('/images',categoryController.getCategoryImages);

router.delete('/categories/:id', categoryController.deleteCategory);
//router.get('/getImages',categoryController.getCategoryImages);
//router.get('/get/:imageName',categoryController.getImageFromFileServer);
//router.get('/:categoryId',categoryController.getCategoryImageById);

module.exports = router;
