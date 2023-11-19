

import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Color from 'App/Models/Color';
import Order from 'App/Models/Order';
import OrderAddress from 'App/Models/OrderAddress';
import OrderProduct from 'App/Models/OrderProduct';
import Size from 'App/Models/Size';


export default class OrdersController {



  public async getOrder({ auth, response }: HttpContextContract) {
    try {
      const user = await auth.authenticate()
      const orders = await Order.query()
        .where('user_id', user.id)
        .preload('order_products', (query) => {
          query
            .preload('product')
        })
        .orderBy('created_at', 'desc') 
      return response.ok({ data: orders })
    } catch (error) {
      console.error(error)
      return response.status(500).json({ error: 'Failed to retrieve orders' })
    }
  }
    async getCountOrder({ auth, response }) {
      try {
        const user = await auth.authenticate()
        const count = await Database.from('orders').where('user_id', user.id).count('* as total')
  
        return response.ok({ count: count[0].total })
      } catch (error) {
        console.error(error)
        return response.status(500).json({ error: 'Failed to retrieve order count' })
      }
    }
  
    async create({ request, response, auth }: HttpContextContract) {
        try {

            var authObject = await auth.authenticate();
            var data = request.all();
            var order = new Order();
            order.userId = authObject.id;
            order.tax_amount = data.tax_amount;
            order.sub_total = data.sub_total;
            order.total_Price=data.total_price;
            order.total = data.total;
            order.payment_method_id = data.payment_method_id;
            var newOrder = await order.save();

            var address = new OrderAddress();
            address.country = data.address.country;
            address.city = data.address.city;
            address.area = data.address.area;
            address.street = data.address.street;
            address.building_no = data.address.building_no;
            address.longitude = data.address.longitude;
            address.latitude = data.address.latitude;
            address.orderId = newOrder.id;
            await address.save();


            var orderProducts: OrderProduct[] = await Promise.all(data.products.map(async (product) => {
              var orderProduct = new OrderProduct();
              orderProduct.orderId = newOrder.id;
              orderProduct.productId = product.product_id;
              orderProduct.qty = product.qty;
              orderProduct.price = product.price;
          
              const color = await Color.findBy('product_id', product.product_id);
              const size = await Size.findBy('product_id', product.product_id);
        
              if (color) {
                orderProduct.colorId = color.id;
              }
        
              if (size) {
                orderProduct.sizeId = size.id;
              }
            
            
              return orderProduct;
            }));
            
            await OrderProduct.createMany(orderProducts);
            return newOrder.toJSON();
        } catch (ex) {
            console.log(ex);
            return response.badRequest({ message: ex });
        }
    }

    public async destroy(ctx: HttpContextContract) {
   
     
      const user = await ctx.auth.authenticate()
   
      let order = await Order.findBy('id', ctx.params.id);
   
      if (!order) {
         throw new Error('The Order does not exist.');
      }
   
     
      if (order.userId !==user.id) {
         throw new Error('Unauthorized');
      }
   
    
      await Database.from('order_products').where('order_id', order.id).delete();
   
    
      await order.delete();
   
      return ctx.response.json({
         success: true,
         data: [],
         message: 'Order deleted correctly',
         status_code: 200,
      });
   }
   
   
}

