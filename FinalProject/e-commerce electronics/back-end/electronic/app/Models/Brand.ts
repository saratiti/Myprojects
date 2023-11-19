import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, HasMany, hasMany, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';

export default class Brand extends BaseModel {
  public static table="brands"
  @column({ isPrimary: true })
  public id: number
  @column({ serializeAs:"brand_name"})
  public brand_name:string;
  @column({ serializeAs:"image"})
  public image:string;
  
  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime


}


