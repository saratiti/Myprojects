
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
  const id = req.params.id; 
  try {
    console.log('Generated Sequelize Query:', { where: { category_id: id } });
    const products = await Product.findAll({
      where: { category_id: id }, 
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

exports.getProductsImages = async (req, res) => {
  try {
    
    const products = await Product.findAll();

    if (!products || products.length === 0) {
      return res.status(404).json({ error: 'No products found' });
    }

    const images = [];

    for (let i = 0; i < products.length; i++) {
      const product = products[i];
      const imagePath = product.image;

      if (!imagePath || !fsread.existsSync(imagePath)) {
    
        console.log(`Skipping category without image: ${product.id}`);
        continue;
      }

      const imageBuffer = fsread.readFileSync(imagePath);
      const base64Image = imageBuffer.toString('base64');
      const contentType = getContentType(path.extname(imagePath).toLowerCase());
      const dataUrl = `data:${contentType};base64,${base64Image}`;
      images.push({ productId: product.id, dataUrl });
    }
    res.status(200).json({ images });
  } catch (error) {
    console.error('Error fetching products images:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

function getContentType(fileExtension) {
  switch (fileExtension) {
    case '.jpg':
    case '.jpeg':
      return 'image/jpeg';
    case '.png':
      return 'image/png';
    case '.gif':
      return 'image/gif';
    default:
      return 'application/octet-stream';
  }
}

exports.deleteProduct = async (req, res) => {
  const productId = req.params.productId;

  try {

    await AdditionalMenu.destroy({
      where: {
        productId: productId
      }
    });


    const deletedProduct = await Product.destroy({
      where: {
        id: productId
      }
    });

    if (deletedProduct === 0) {
      return res.status(404).json({ message: 'Product not found' });
    }

    res.status(200).json({ message: 'Product and associated optional menu items deleted successfully' });
  } catch (error) {
    console.error('Error deleting product:', error.message);
    res.status(500).send('Server Error');
  }
};