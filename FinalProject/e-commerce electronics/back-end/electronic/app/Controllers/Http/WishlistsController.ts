import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database'
import Wishlist from 'App/Models/Wishlist'

export default class WishlistsController {

  public async getWishlists(ctx: HttpContextContract) {
    try {
      const user = await ctx.auth.authenticate()
      const orders = await Wishlist.query()
        .where('user_id', user.id)
        .preload('product')
        .orderBy('created_at', 'desc') 
      return ctx.response.ok({ data: orders })
    } catch (error) {
      console.error(error)
      return ctx.response.status(500).json({ error: 'Failed to retrieve wishlist' })
    }
  }
  
  

  async create({ request, response, auth }) {
    try {
      const authObject = await auth.authenticate();
      const data = request.all();
  
      const wishlist = new Wishlist();
      wishlist.user_id = authObject.id;
      wishlist.product_id = data.product_id;
  
      const newWishlist = await wishlist.save();
  
      return newWishlist;
    } catch (ex) {
      console.log(ex);
      return response.badRequest({ message: ex });
    }}
      
      async deleteWishlist ({ params, auth, response }) {
        const wishlist = await Wishlist.query()
          .where('id', params.id)
          .where('user_id', auth.user.id)
          .first()
      
        if (!wishlist) {
          return response.status(404).json({ error: 'Wishlist not found.' })
        }
      
        await wishlist.save()
      
        return response.status(200).json(wishlist)
      }

      public async destroy(ctx: HttpContextContract) {
      
        const user = await ctx.auth.authenticate();
      
        let wishlist = await Wishlist.findBy('id', ctx.params.id);
      
        if (!wishlist) {
          throw new Error('The Wishlist does not exist.');
        }
      
        if (wishlist.user_id !== user.id) {
          throw new Error('Unauthorized');
        }
      
       
        await Database.from('order_products').where('product_id', wishlist.product_id).update({
          product_id: null  
        });
      
       
        await wishlist.delete();
      
        return ctx.response.json({
          success: true,
          data: [],
          message: 'Wishlist deleted successfully',
          status_code: 200,
        });

    }


  }

