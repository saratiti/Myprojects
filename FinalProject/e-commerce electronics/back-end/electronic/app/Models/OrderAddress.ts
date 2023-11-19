import { DateTime } from 'luxon'

import { column,  BaseModel, belongsTo, BelongsTo } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'

export default class OrderAddress extends BaseModel {
    public static table="order_addresses"
    @column({ isPrimary: true })
    public id: number

    @column({ serializeAs: "order_id" })
    public orderId: number

    @column({ serializeAs: "longitude" })
    public longitude: number

    @column({ serializeAs: "latitude" })
    public latitude: number

    @column({ serializeAs: "city" })
    public city: String

    @column({ serializeAs: "country" })
    public country: String

    @column({ serializeAs: "area" })
    public area: String

    @column({ serializeAs: "street" })
    public street: String

    @column({ serializeAs: "building_no" })
    public building_no: String

    @column.dateTime({ autoCreate: true })
    public createdAt: DateTime

    @column.dateTime({ autoCreate: true, autoUpdate: true })
    public updatedAt: DateTime

    @belongsTo(() => Order)
    public order: BelongsTo<typeof Order>
  

}