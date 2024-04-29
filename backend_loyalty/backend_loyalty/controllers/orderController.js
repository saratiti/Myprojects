
const Order = require('../models/order');
const OrderProduct = require('../models/orderProduct');
const Invoice=require('../models/invoice');
exports.getOrder = async (req, res) => {
  try {
    const user = req.user;
    const orders = await Order.query()
      .where('user_id', user.id)
      .with('order_products', (query) => {
        query.with('product');
      })
      .orderBy('created_at', 'desc');
    return res.status(200).json({ data: orders });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to retrieve orders' });
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
        order_id: newOrder.order_id,  
        upload_date: new Date().toISOString(),
        total_amount: data.total,
      });

      console.log('New Invoice:', invoice.toJSON());

      return invoice;
    }));

    const orderProducts = await Promise.all(data.products.map(async (product) => {
      const orderProduct = await OrderProduct.create({
        order_id: newOrder.order_id,
        product_id: product.product_id,
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
    const user = req.user; 
    const orderId = req.params.id;

    let order = await Order.find(orderId);

    if (!order) {
      throw new Error('The Order does not exist.');
    }

    if (order.userId !== user.id) {
      throw new Error('Unauthorized');
    }

    await OrderProduct.query().where('order_id', order.id).delete();
    await order.delete();

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