import { DateTime } from 'luxon'

import { column,  BaseModel, hasMany, HasMany, belongsTo, BelongsTo } from '@ioc:Adonis/Lucid/Orm'
import OrderProduct from './OrderProduct'
import User from './User'

export default class Order extends BaseModel {
    @column({ isPrimary: true })
    public id: number
  
    @column({ serializeAs: 'user_id' })
    public userId: number
  
    @column({ serializeAs: 'total_price' })
    public total_Price: number
  
    @column({ serializeAs: 'total' })
    public total: number
  
    @column({ serializeAs: 'sub_total' })
    public sub_total: number
  
    @column({ serializeAs: 'tax_amount' })
    public tax_amount: number
  
    @column({ serializeAs: 'payment_method_id' })
    public payment_method_id: number
  
    @column({ serializeAs: 'status_id' })
    public status_id: number
  
    @column.dateTime({ autoCreate: true })
    public createdAt: DateTime
  
    @column.dateTime({ autoCreate: true, autoUpdate: true })
    public updatedAt: DateTime
    @belongsTo(() => User, {
      foreignKey: 'user_id',
    })
    public user: BelongsTo<typeof User>
  
    @hasMany(() => OrderProduct)
    public order_products: HasMany<typeof OrderProduct>
  }