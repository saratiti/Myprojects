import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database'
import Cart from 'App/Models/Cart'


export default class CartsController {

  public async getCarts (ctx:HttpContextContract) {
    try {
      const user = await ctx.auth.authenticate()
      const orders = await Cart.query()
        .where('user_id', user.id)
        .preload('product')
        
      return ctx.response.ok({ data: orders })
    } catch (error) {
      console.error(error)
      return ctx.response.status(500).json({ error: 'Failed to retrieve cart' })
    }}

  

  async create({ request, response, auth }) {
    try {
      const authObject = await auth.authenticate();
      const data = request.all();
  
      const cart = new Cart();
      cart.userId= authObject.id;
      cart.product = data.product_id;
  
      const newWishlist = await cart.save();
  
      return newWishlist;
    } catch (ex) {
      console.log(ex);
      return response.badRequest({ message: ex });
    }}
      
      async deleteCart ({ params, auth, response }) {
        const cart = await Cart.query()
          .where('id', params.id)
          .where('user_id', auth.user.id)
          .first()
      
        if (!cart) {
          return response.status(404).json({ error: 'Cart not found.' })
        }
      
        await cart.save()
      
        return response.status(200).json(cart)
      }

      public async destroy(ctx: HttpContextContract) {
      
        const user = await ctx.auth.authenticate();
      
        let cart = await Cart.findBy('id', ctx.params.id);
      
        if (!cart) {
          throw new Error('The Wishlist does not exist.');
        }
      
        if (cart.userId !== user.id) {
          throw new Error('Unauthorized');
        }
      
       
        await Database.from('order_products').where('product_id', cart.product_id).update({
          product_id: null  
        });
      
       
        await cart.delete();
      
        return ctx.response.json({
          success: true,
          data: [],
          message: 'cart deleted successfully',
          status_code: 200,
        });

    }


  }

