import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'
import Product from './Product'
import Color from './Color'
import Size from './Size'

export default class OrderProduct extends BaseModel {
  public static table = 'order_products'

  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'order_id' })
  public orderId: number

  @column({ serializeAs: 'product_id' })
  public productId: number

  @column({ serializeAs: 'qty' })
  public qty: number

  @column({ serializeAs: 'price' })
  public price: number

  @column({ serializeAs: 'color_id' })
  public colorId: number | undefined

  @column({ serializeAs: 'size_id' })
  public sizeId: number | undefined

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Order)
  public order: BelongsTo<typeof Order>

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>

  @manyToMany(() => Color, {
    pivotTable: 'product_colors',
  })
  public colors: ManyToMany<typeof Color>;
  
  @manyToMany(() => Size, {
    pivotTable: 'product_sizes',
  })
  public sizes: ManyToMany<typeof Size>;
  

}
  
  
  
