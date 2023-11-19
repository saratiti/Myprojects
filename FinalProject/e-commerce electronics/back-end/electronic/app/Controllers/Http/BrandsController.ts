 import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Brand from 'App/Models/Brand'
import { schema } from '@ioc:Adonis/Core/Validator'
import Product from 'App/Models/Product'


export default class BrandsController {

   async getByBrandId({ params, response }) {
      const { brandId } = params
  
      try {
        const products = await Product.query()
          .where('brandId', brandId)
          .firstOrFail()
  
        return response.status(200).json(products)
      } catch (error) {
        return response.status(500).json({
          message: 'An error occurred while fetching products.',
          error: error.message
        })
      }
    }
  
  
 
  
  

   public async filterByName(ctx: HttpContextContract) {
      try {
        
        const brand = await Brand.query().where('brandName',ctx.params.brand_name).first()
    
        if (!brand) {
          return ctx.response.status(404).json({
            success: false,
            data: null,
            message: 'The brand does not exist.',
            status_code: 404
          })
        }
    
        return ctx.response.json({
          success: true,
          data: brand,
          message: 'Brand detailed correctly',
          status_code: 200
        })
      } catch (error) {
        return ctx.response.status(500).json({
          success: false,
          data: null,
          message: 'Failed to filter brand by name.',
          status_code: 500
        })
      }
    }
     public async getById(ctx: HttpContextContract) {
        const brand = await Brand.findBy('id',ctx.params.id)
  
        if (!brand) throw new Error('The brand does not exist.')
  
        return ctx.response.json({
           success: true,
           data: brand,
           message: 'Brand detailed correctly',
           status_code: 200
        })
     }
     public async getAll({}: HttpContextContract) {
        return await Brand.all()
     }
     public async create(ctx: HttpContextContract) {
   
      const newSchema = schema.create({
          brand_name:schema.string(),
       
          
      });

   
      const fields = await ctx.request.validate({ schema: newSchema })
      var brand = new Brand();
   
      brand.brand_name=fields.brand_name;
   
      var result = await brand.save();
      return result;
  

  
   }
  
  
     public async update(ctx: HttpContextContract) {
        let brand = await Brand.findBy('id', ctx.params.id)
  
        if (!brand) throw new Error('The brand does not exist.')
  
        brand.brand_name= ctx.request.body().brand_name
        await brand.save()
  
        return ctx.response.json({
           success: true,
           data: [],
           message: 'Brand updated correctly',
           status_code: 200
        })
     }
  


     public async destroy(ctx: HttpContextContract) {
        let brand = await Brand.findBy('id',ctx.params.id)
  
        if (!brand) throw new Error('The brand does not exist.')
  
        await brand.delete()
  
        return ctx.response.json({
           success: true,
           data: [],
           message: 'Brand deleted correctly',
           status_code: 200
        })
     }
  }












