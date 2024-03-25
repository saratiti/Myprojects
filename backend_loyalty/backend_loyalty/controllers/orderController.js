
const Order = require('../models/order');
const OrderProduct = require('../models/orderProduct');
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
    const authObject = req.user; 
    const data = req.body;

    const order = new Order();
    order.userId = authObject.id;
    order.tax_amount = data.tax_amount;
    order.sub_total = data.sub_total;
    order.total_Price = data.total_price;
    order.total = data.total;
    order.payment_method_id = data.payment_method_id;
    const newOrder = await order.save();

   
    const orderProducts = await Promise.all(data.products.map(async (product) => {
      const orderProduct = new OrderProduct();
      orderProduct.orderId = newOrder.id;
      orderProduct.productId = product.product_id;
      orderProduct.qty = product.qty;
      orderProduct.price = product.price;

     
      if (color) {
        orderProduct.colorId = color.id;
      }

      if (size) {
        orderProduct.sizeId = size.id;
      }

      return orderProduct;
    }));

    await OrderProduct.createMany(orderProducts);
    return res.status(201).json(newOrder.toJSON());
  } catch (ex) {
    console.log(ex);
    return res.status(400).json({ message: ex });
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