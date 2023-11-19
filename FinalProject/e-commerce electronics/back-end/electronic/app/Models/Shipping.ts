import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order';

export default class Shipping extends BaseModel {
  public static table = "shippings"
  @column({ isPrimary: true })
  public id: number
  @column({ serializeAs: "order_id" })
  public orderId: number;

  @column({ serializeAs: "shipping_carrier" })
  public shippingCarrier: string;

  @column({ serializeAs: "shipping_method" })
  public shippingMethod: string;
  @column({ serializeAs: "tracking_number" })
  public trackingNumber: number;

  @column({ serializeAs: "shipping_cost" })
  public shippingCost: number;
  @column({ serializeAs: "delivery_date" })
  public delivery_date: DateTime;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Order, {
      foreignKey: 'orderId',
  })
  public orderID: BelongsTo<typeof Order>
}
