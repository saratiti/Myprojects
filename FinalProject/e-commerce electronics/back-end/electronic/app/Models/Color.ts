import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';
import ProductVariant from './product_variant';

export default class Color extends BaseModel {
  public static table = "product_colors"

  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: "color" })
  public color: string

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
