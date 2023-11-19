import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';
import User from './User';

export default class Wishlist extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs:"user_id"})
  public user_id:number;

  @column({ serializeAs:"product_id"})
  public product_id:number;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => User, {
    foreignKey: 'user_id',
  })
  public user: BelongsTo<typeof User>

  @belongsTo(() =>Product, {
    foreignKey:'product_id',
  })
  public  product: BelongsTo<typeof Product>




}


