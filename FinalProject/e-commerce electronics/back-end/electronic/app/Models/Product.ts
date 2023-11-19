

import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Category from './Category'
import Brand from './Brand'
import Size from './Size'
import ProductVariant from './product_variant'


export default class Product extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: "name" })
  public name: String

  @column({ serializeAs: "price" })
  public price: number

  @column({ serializeAs: "image" })
  public image: String

  @column({ serializeAs: "category_id" })
  public categoryId: number

  @column({ serializeAs: "brand_id" })
  public brandId: number

  @column({ serializeAs: "quantity" })
  public currentQty: number

  @column({ serializeAs: "description" })
  public description: String

  @column({ serializeAs: "active" })
  public active: boolean

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime()
  public deletedAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Category)
  public category: BelongsTo<typeof Category>

  @belongsTo(() => Brand)
  public brand: BelongsTo<typeof Brand>
  
  @hasMany(() => ProductVariant)
  public variants: HasMany<typeof ProductVariant>


}
