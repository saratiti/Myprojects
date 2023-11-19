import { DateTime } from 'luxon'
import { BaseModel, belongsTo, BelongsTo, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product';
import Brand from './Brand';

export default class Category extends BaseModel {
 
  public static table="categories"
  @column({ isPrimary: true })
  public id: number
  @column({ serializeAs:"name"})
  public name:string;

  @column({ serializeAs:"image"})
  public image:string;
  @column({ serializeAs: "brand_id" })
  public brandId: number

  @column({ serializeAs:"active"})
  public active:boolean;
  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime



}



