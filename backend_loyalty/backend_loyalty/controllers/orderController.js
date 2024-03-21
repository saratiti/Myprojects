
const Order = require('../models/Order');

exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.findAll();
    res.json(orders);
  } catch (error) {
    console.error('Error retrieving orders:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createOrder = async (req, res) => {
  try {
    const newOrder = await Order.create(req.body);
    res.status(201).json({ message: 'Order created successfully', newOrder });
  } catch (error) {
    console.error('Error creating order:', error.message);
    res.status(500).send('Server Error');
  }
};
