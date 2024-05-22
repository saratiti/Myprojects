

const OptionalMenu = require('../models/additional_menue');
const Product = require('../models/product');
const OptionProduct = require('../models/option_product');
exports.getAllOptionalMenus = async (req, res) => {
  try {
    const optionalMenus = await OptionalMenu.findAll();
    res.json(optionalMenus);
  } catch (error) {
    console.error('Error retrieving optional menus:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createOptionalMenu = async (req, res) => {
  try {
    const newOptionalMenu = await OptionalMenu.create(req.body);
    res.status(201).json({ message: 'Optional menu created successfully', newOptionalMenu });
  } catch (error) {
    console.error('Error creating optional menu:', error.message);
    res.status(500).send('Server Error');
  }
};
exports.getOptionalMenuByProductId = async (req, res) => {
  const productId = req.params.productId;

  try {

    const product = await Product.findByPk(productId);
    if (!product) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const optionalMenuItems = await OptionProduct.findAll({
      where: { product_id: productId },
      include: [{ model: OptionalMenu, as: 'options' }]
    });


    const responseData = {
      product: product,
      optionalMenuItems: optionalMenuItems || []
    };

    return res.status(200).json(responseData);
  } catch (error) {
    console.error('Error retrieving optional menu items:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};
