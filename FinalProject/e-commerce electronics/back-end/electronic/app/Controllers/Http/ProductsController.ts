import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Color from 'App/Models/Color';
import Product from 'App/Models/Product';
import Size from 'App/Models/size';



export default class ProductsController {


  async getByBrandAndCategory({ params, response }) {
    const { brandId, categoryId } = params

    try {
      const products = await Product.query()
        .where('brandId', brandId)
        .where('categoryId', categoryId)
        .preload('brand')
        .preload('category')

      return response.status(200).json(products)
    } catch (error) {
      return response.status(500).json({
        message: 'An error occurred while fetching products.',
        error: error.message
      })
    }
  }




  async getBrandsByCategoryId({ params, response }) {
    const { categoryId } = params
  
    try {
      const brands = await Database.from('products')
        .where('category_id', categoryId)
        .distinct('brand_id')
        .innerJoin('brands', 'products.brand_id', 'brands.id')
        .select('brands.*')
  
      return response.status(200).json(brands)
    } catch (error) {
      return response.status(500).json({
        message: 'An error occurred while fetching brands.',
        error: error.message
      })
    }
  }
  

  async getProductByColor({ params }) {
    const { productId } = params
    const colorProducts = await Color.query().where('product_id', productId).preload('product')
    return colorProducts
  }



  async getProductSize({ response, params }) {
    const { productId } = params
    const sizeProducts = await Size.query().where('product_id', productId).preload('product')
    return sizeProducts
  }
  

  public async getById(ctx: HttpContextContract) {
    var id = ctx.params.id;
    var result = await Product.findOrFail(id);
    return result;
  }
  



  
  public async getAll({ request }: HttpContextContract) {
    var query = Product.query()
        .where('active', true)
        .preload('category', (subQry) => {
            subQry.where('active', true);
        })
        .preload("brand"); 

    if (request.input('categoryId')) {
        query.where('categoryId', request.input('categoryId'));
    }

    var result = await query;
    var products: Product[] = [];
    result.map((product) => {
        if (product.category) {
            products.push(product);
        }
    });
    return products;
}


  // public async create(ctx: HttpContextContract) {
  //    await ctx.auth.authenticate();
  //   const newSchema = schema.create({
  //     name: schema.string(),
  //     image: schema.string(),
  //     price:schema.number(),
  //     currentQty:schema.number(),
  //     description:schema.string(),


  //   });
  //   const fields = await ctx.request.validate({ schema: newSchema })

  //   var product = new Product();
  //   product.productName = fields.name;
  //   product.imageProduct = fields.image;
  //   product.priceProduct = fields.price;
  //   product.quantityInStock = fields.currentQty;
  //   product.descriptionProduct = fields.description;
 
  //   var result = await product.save();
  //   return result;


  // }
  // public async update(ctx: HttpContextContract) {
  //   var object = await ctx.auth.authenticate();
  //   var fields = ctx.request.all();
  //   var id = object.id;
  //   var product = await Product.findOrFail(id);
  //   product.productName = fields.name;
  //   product.imageProduct = fields.image;
  //   product.priceProduct = fields.price;
  //   product.quantityInStock = fields.currentQty;
  //   product.descriptionProduct = fields.description;
  //   var result = await product.save();
  //   return result;
  // }
  // public async destroy(ctx: HttpContextContract) {
  //   var id = ctx.params.id;
  //   var product = await Product.findOrFail(id);
  //   await product.delete();
  //   return { message: "The product has been deleted!" };
  // }


  }



