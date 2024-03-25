
const Product = require('../models/product');

exports.getAllProducts = async (req, res) => {
  try {
    const products = await Product.findAll();
    res.json(products);
  } catch (error) {
    console.error('Error retrieving products:', error.message);
    res.status(500).send('Server Error');
  }
};
exports.getProductsByCategory = async (req, res) => {
  const categoryId = req.params.categoryId; 
  try {
    const products = await Product.findAll({
      where: { category_id: categoryId },
    });
    if (products.length === 0) {
      return res.status(404).json({ message: 'No products found for this category' });
    }
    res.json(products);
  } catch (error) {
    console.error('Error retrieving products by category:', error.message);
    res.status(500).send('Server Error');
  }
};
exports.createProduct = async (req, res) => {
  try {
    const newProduct = await Product.create(req.body);
    res.status(201).json({ message: 'Product created successfully', newProduct });
  } catch (error) {
    console.error('Error creating product:', error.message);
    res.status(500).send('Server Error');
  }
  
};
