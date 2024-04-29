
const OrderProduct = require('../models/orderProduct');
const Order=require('../models/order');
const Product=require('../models/product');
exports.createOrderProduct = async (req, res) => {
  try {
    const newOrderProduct = await OrderProduct.create(req.body);
    res.status(201).json({ message: 'Order product created successfully', newOrderProduct });
  } catch (error) {
    console.error('Error creating order product:', error.message);
    res.status(500).send('Server Error');
  }


};
exports.getAllorderProduct = async (req, res) => {
  try {
    const orderProducts = await OrderProduct.findAll({
      include: [
        {
          model: Order,
          as: 'orders',
        },
        {
          model: Product,
          as: 'products',
        },
      ],
      order: [
        ['order_id', 'ASC'],
      ],
    });

    if (!orderProducts || orderProducts.length === 0) {
      return res.status(404).json({ message: 'No order products found' });
    }

    
    const groupedOrderProducts = {};
    orderProducts.forEach(orderProduct => {
      const orderId = orderProduct.order_id;
      if (!groupedOrderProducts[orderId]) {
        groupedOrderProducts[orderId] = [];
      }
      groupedOrderProducts[orderId].push(orderProduct);
    });


    const groupedOrderProductsIntKeys = Object.fromEntries(
      Object.entries(groupedOrderProducts).map(([key, value]) => [parseInt(key), value])
    );

    res.status(200).json(groupedOrderProductsIntKeys);
  } catch (error) {
    console.error('Error retrieving order products:', error.message);
    res.status(500).send('Server Error');
  }
};
