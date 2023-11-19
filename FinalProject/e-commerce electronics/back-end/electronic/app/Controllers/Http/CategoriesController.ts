 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Brand from 'App/Models/Brand';
import Category from 'App/Models/Category'
import Product from 'App/Models/Product';

export default class CategoriesController {


   

     public  async getAll (ctx:HttpContextContract) {
        
        const categories = await Category.query()
        return categories;
      }

      public async getProductsByCategory({ params }: HttpContextContract) {
        const categoryId = params.id
    
        const products = await Product.query()
          .where('category_id', categoryId)
          
    
        return products
      }
   
    
      async update ({ params, request }) {
        const { name } = request.post()
    
        const category = await Category.findOrFail(params.id)
        category.name = name
    
        await category.save()
    
        return category.toJSON()
      }
    

      async destroy (ctx:HttpContextContract) {
        const category = await Category.find(ctx.params.id)
    
        if (!category) {
          return ctx.response.status(404).send({
            error: 'Category not found'
          })
        }
    
        await category.delete()
    
        return {
          message: 'Category deleted successfully'
        }
      }
    
      




     


}
