import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import User from './User';
import Product from './Product';

export default class Review extends BaseModel {
  public static table="reviews"
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs:"user_id"})
  public user_id:number;

  @column({ serializeAs:"product_id"})
  public product_id:number;

  @column({ serializeAs:"rating"})
  public rating:number;

  @column({ serializeAs:"comment"})
  public comment:string;
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
