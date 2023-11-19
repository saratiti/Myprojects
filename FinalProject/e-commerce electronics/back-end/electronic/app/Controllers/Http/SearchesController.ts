 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Brand from 'App/Models/Brand'
import Category from 'App/Models/Category'
import Product from 'App/Models/Product'


export default class SearchesController {
    
    async search({ params }) {
        const searchTerm = params.searchTerm
      
       
        const products = await Product.query()
          .where('name', 'like', `%${searchTerm}%`)
          .preload('brand')
          .preload('category')
        
      
        const brands = await Brand.query()
          .where('brand_name', 'like', `%${searchTerm}%`)
         
      
      
        const categories = await Category.query()
          .where('name', 'like', `%${searchTerm}%`)
         
      
        return {
          products,
          brands,
          categories
        }
      }
    
}
    


