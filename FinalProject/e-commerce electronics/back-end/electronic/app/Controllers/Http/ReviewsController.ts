import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Database from '@ioc:Adonis/Lucid/Database';

import Product from 'App/Models/Product';
import Review from 'App/Models/Review';

export default class ReviewsController {


  public async getReview({ auth, response }: HttpContextContract) {
    try {
      const user = await auth.authenticate()
      const orders = await Review.query()
        .where('user_id', user.id)
        .preload('product')
        .preload('user')
        .orderBy('created_at', 'desc') 
  
      return response.ok({ data: orders })
    } catch (error) {
      console.error(error)
      return response.status(500).json({ error: 'Failed to retrieve orders' })
    }}

    async getCount({ auth, response }) {
      try {
        const user = await auth.authenticate()
        const count = await Database.from('reviews').where('user_id', user.id).count('* as total')
  
        return response.ok({ count: count[0].total })
      } catch (error) {
        console.error(error)
        return response.status(500).json({ error: 'Failed to retrieve review count' })
      }
    }
  async getTopRatedProducts() {
    try {
      const topProducts = await Review.query()
        .select('product_id')
        .avg('rating as averageRating')
        .groupBy('product_id')
        .orderBy('averageRating', 'desc')
        .limit(10);

      const productIds = topProducts.map((item) => item.product_id);

      const products = await Product.query()
        .whereIn('id', productIds)
        .preload('brand')
        .exec();

      return products;
    } catch (error) {
      console.error('Error retrieving top-rated products:', error);
      return [];
    }
  }
  public async getProductReviews({ params }: HttpContextContract) {
    try {
      const product = await Product.findOrFail(params.id)
      const reviews = await Review.query()
        .where('product_id', product.id)
        .preload('user')
        .preload('product')

      const totalRatings = reviews.reduce((sum, review) => sum + review.rating, 0)
      const averageRating = totalRatings / reviews.length

      return {
        averageRating,
        reviews,
      }
    } catch (error) {
      console.error('Error retrieving product reviews:', error)
      throw error
    }
  }
  async getAllReviews({ response }) {
    try {
      const reviews = await Review.all();

      return response.status(200).json({
        success: true,
        reviews,
      });
    } catch (error) {
      return response.status(500).json({
        success: false,
        message: 'Error retrieving reviews',
      });
    }
  }

  async updateReview({ request, params, auth, response }) {
    try {
      const review = await Review.findOrFail(params.id);

      if (!review) {
        return response.status(404).json({ message: `Review is not found with id of ${params.id}` });
      }

      const findReview = await Review.query()
        .where('_id', params.id)
        .where('userId', auth.user.id)
        .first();

      if (!findReview && auth.user.role !== 'admin') {
        return response.status(400).json({ message: 'Not authorized to update this review' });
      }

      review.merge(request.only(['rating', 'comment']));
      await review.save();

      return response.status(200).json({
        status: 'success',
        data: review,
      });
    } catch (error) {
      console.error('Error updating review:', error);
      return response.status(500).json({ message: 'Internal Server Error' });
    }
  }

 
  async create({ request, response, auth }) {
    try {
      const authObject = await auth.authenticate();
      const data = request.all();
      
      const review = new Review();
      review.user_id = authObject.id;
      review.comment = data.comment;
      review.rating = data.rating;
      review.product_id = data.product_id;
      
      const newReview = await review.save();
  
      return newReview;
    } catch (ex) {
      console.log(ex);
      return response.badRequest({ message: ex });
    }
  }
  
  public async destroy(ctx: HttpContextContract) {
    const user = await ctx.auth.authenticate()

    const review = await Review.findBy('id', ctx.params.id)

    if (!review) {
      return ctx.response.notFound({ error: 'The Review does not exist.' })
    }

    if (review.user_id !== user.id) {
      return ctx.response.unauthorized({ error: 'Unauthorized' })
    }

    await review.delete()

    return { success: true, message: 'Review deleted successfully', status_code: 200 }
  }
 }
 
 





