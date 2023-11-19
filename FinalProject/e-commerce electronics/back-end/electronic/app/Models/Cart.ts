import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';
import User from './User';

export default class Cart extends BaseModel {
  public static table="carts"
  @column({ isPrimary: true })
  public id: number
  @column({ serializeAs:"user_id"})
  public userId:number;
  @column({ serializeAs:"product_id"})
  public product_id:number;
  @column({ serializeAs:"quntity"})
  public  quntityProduct:number;
  @column({serializeAs:"product_attribute"})
  public productAttributes:string;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  @belongsTo(() => Product, {
    foreignKey: 'product_id',
  })
  public  product: BelongsTo<typeof Product>

  @belongsTo(() => User, {
    foreignKey: 'userId',
  })
  public  user: BelongsTo<typeof User>
}
