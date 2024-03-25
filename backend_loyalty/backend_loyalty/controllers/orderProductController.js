
const OrderProduct = require('../models/orderProduct');

exports.createOrderProduct = async (req, res) => {
  try {
    const newOrderProduct = await OrderProduct.create(req.body);
    res.status(201).json({ message: 'Order product created successfully', newOrderProduct });
  } catch (error) {
    console.error('Error creating order product:', error.message);
    res.status(500).send('Server Error');
  }
};
