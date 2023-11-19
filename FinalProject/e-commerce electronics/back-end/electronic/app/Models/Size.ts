import { DateTime } from 'luxon'
import { BaseModel,BelongsTo,belongsTo,column, HasMany, hasMany, } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';
import ProductVariant from './product_variant';


export default class Size extends BaseModel {
  public static table="product_sizes"
  @column({ isPrimary: true })
  public id: number
  @column({ serializeAs:"size"})
  public size:string;
  @column({ serializeAs: "product_id" })
  public productId: number  

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>

 

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  @hasMany(() => ProductVariant)
  public variants: HasMany<typeof ProductVariant>


}


