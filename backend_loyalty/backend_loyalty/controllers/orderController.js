
const Order = require('../models/order');
const OrderProduct = require('../models/orderProduct');
const Invoice=require('../models/invoice');
const User=require('../models/user');
const Product=require('../models/product');


exports.getAllorder = async (req, res) => {
  try {


    const orders = await Order.findAll();

   
    const orderIds = orders.map(order => order.id);

    const orderProducts = await OrderProduct.findAll({
      where: { order_id: orderIds },
      include: { model: Product, as: 'products' }, 
    });


    const responseData = orders.map(order => {
      const associatedOrderProducts = orderProducts.filter(op => op.order_id === order.id);
      return { ...order.toJSON(), orderProducts: associatedOrderProducts };
    });

    return res.status(200).json({ data: responseData });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve order products' });
  }
};


exports.getCountOrder = async (req, res) => {
  try {
    const user = req.user;
    const count = await Order.query().where('user_id', user.id).count('* as total');
    return res.status(200).json({ count: count[0].total });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve order count' });
  }
};

exports.create = async (req, res) => {
  try {
    console.log('Incoming data:', req.body);

    const userId = req.user_id;
    
    console.log('User ID:', req.user_id);
    
    const data = req.body;

    
    if (!data.products || !data.total || !data.total_price) {
      throw new Error('Invalid product data');
    }

   
    const newOrder = await Order.create({
      user_id: userId,
      total: data.total,
      total_price: data.total_price,
    });

    console.log('New Order:', newOrder.toJSON());
    const invoices = await Promise.all(data.products.map(async (product) => {
      const invoice = await Invoice.create({
        user_id: userId,
        order_id: newOrder.id,  
        upload_date: new Date().toISOString(),
        total_amount: data.total,
      });

      console.log('New Invoice:', invoice.toJSON());

      return invoice;
    }));

    const orderProducts = await Promise.all(data.products.map(async (product) => {
      const orderProduct = await OrderProduct.create({
        order_id: newOrder.id,
        product_id: product.id,
        qty: product.qty,
        price: product.price,
      });
    
      return orderProduct;
    }));
    
    

    console.log('Order created successfully:', newOrder);

    return res.status(201).json(newOrder);
  } catch (ex) {
    console.error('Error creating order:', ex);
    return res.status(400).json({ message: ex.message });
  }
};

exports.destroy = async (req, res) => {
  try {
    const userId = req.user_id;
    const orderId = req.params.orderId;

    let order = await Order.findOne({
      where: { id: orderId },
    });
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found.',
      });
    }

    if (order.user_id !== userId) {
      return res.status(403).json({
        success: false,
        message: 'Unauthorized to delete this order.',
      });
    }

    try {
      
      await OrderProduct.destroy({ where: { order_id: orderId } });

  
      await Invoice.destroy({ where: { order_id: orderId } });

     
      await order.destroy();
    } catch (error) {
      console.error('Error deleting related records:', error);
      return res.status(500).json({ message: 'Failed to delete order and related records.' });
    }

    return res.status(200).json({
      success: true,
      data: [],
      message: 'Order deleted successfully',
    });
  } catch (error) {
    console.error('Error deleting order:', error);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
};

exports.getAllorderProductByUserId = async (req, res) => {
  try {
    const userId = req.user_id;

    // Retrieve all orders for the user
    const orders = await Order.findAll({ where: { user_id: userId } });

    if (!orders || orders.length === 0) {
      return res.status(404).json({ error: 'No orders found for the user' });
    }

    // Extract all order IDs
    const orderIds = orders.map(order => order.id);

    // Retrieve all OrderProduct entries that match the order IDs
    const orderProducts = await OrderProduct.findAll({
      where: { order_id: orderIds },
      include: { model: Product, as: 'products' }, 
    });

 
    const responseData = orders.map(order => {
      const associatedOrderProducts = orderProducts.filter(op => op.order_id === order.id);
      return { ...order.toJSON(), orderProducts: associatedOrderProducts };
    });

    return res.status(200).json({ data: responseData });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve order products' });
  }
};


exports.destroyOrderCashier = async (req, res) => {
  try {
  
    const orderId = req.params.orderId;

    let order = await Order.findOne({
      where: { id: orderId },
    });
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found.',
      });
    }

    try {
      
      await OrderProduct.destroy({ where: { order_id: orderId } });

  
      await Invoice.destroy({ where: { order_id: orderId } });

     
      await order.destroy();
    } catch (error) {
      console.error('Error deleting related records:', error);
      return res.status(500).json({ message: 'Failed to delete order and related records.' });
    }

    return res.status(200).json({
      success: true,
      data: [],
      message: 'Order deleted successfully',
    });
  } catch (error) {
    console.error('Error deleting order:', error);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
};