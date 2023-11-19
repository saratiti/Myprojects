import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'
import Product from './Product'
import Color from './Color'
import Size from './Size'

export default class ProductVariant extends BaseModel {
  public static table = 'product_variants'

  @column({ isPrimary: true })
  public id: number


  @column({ serializeAs: 'product_id' })
  public productId: number




  @column({ serializeAs: 'color_id' })
  public colorId: number | undefined

  @column({ serializeAs: 'size_id' })
  public sizeId: number | undefined

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime



  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>

  @belongsTo(() => Color)
  public color: BelongsTo<typeof Color>

  @belongsTo(() => Size)
  public size: BelongsTo<typeof Size>



  

}
  
  
  
