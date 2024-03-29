import { DateTime } from 'luxon'
<<<<<<< HEAD
import {  afterDelete, beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
=======
import {  afterDelete, beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import Product from './Product'
import Section from './Section'
import Order from './Order'
import Address from 'App/Models/Address'
import Email from 'App/Models/ContactOptions/Email'
import Phone from 'App/Models/ContactOptions/Phone'
import { Image } from 'App/Models/File'
import MerchantProfile from '../../profiles/MerchantProfile'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
<<<<<<< HEAD
export enum StoreStatus {
  panding = 1,
  active = 2,
  inactive = 3,
  suspended = 4,
=======
import StoreTranslation from 'App/Models/translations/StoreTranslation'
import { usePivot } from 'Dot/hooks/orm'
export enum StoreStatus {
  panding = 0,
  active = 1,
  inactive = 2,
  suspended = 3,
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
export default class Store extends DotBaseModel {

  @column()
  public name: string

  @column()
  public description: string|null

  //status
  @column()
  public status: StoreStatus

  @column.dateTime()
  public validatedAt: DateTime|null

  @column.dateTime()
  public deletedAt: DateTime|null

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  // Relations
  @hasMany(() => Product)
  public products: HasMany<typeof Product>

  @hasMany(() => Section)
  public categories: HasMany<typeof Section>

  @hasMany(() => Order)
  public orders: HasMany<typeof Order>

<<<<<<< HEAD
=======
  @hasMany(() => StoreTranslation)
  public translations: HasMany<typeof StoreTranslation>

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  @hasOne(() => Address, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'stores:address')
    }
  })
  public address: HasOne<typeof Address>


  @hasOne(() => Email, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'stores:email')
    }
  })
  public email: HasOne<typeof Email>

  @hasOne(() => Phone, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'stores:phone')
    }
  })
  public phone: HasOne<typeof Phone>

<<<<<<< HEAD

  @hasOne(() => Image, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'stores:photo')
    }
  })
  public photo: HasOne<typeof Image>
=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  // @hasOne(() => Image, {
  //   foreignKey: "relatedId",
  //   onQuery: (builder) => {
  //     builder.where('related_type', 'stores:photo')
  //   }
  // })
  // public photo: HasOne<typeof Image>

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>
  // belongs to

  @belongsTo(() => MerchantProfile)
  public merchant: BelongsTo<typeof MerchantProfile>

  // merchantProfileId
  @column()
  public merchantProfileId: string


  // load photo after fetch
<<<<<<< HEAD
  // @beforeFetch()
  // public static async loadPhoto(query: ModelQueryBuilderContract<typeof Store>) {
  //   query.preload('photo')
  // }
=======
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Store>) {
    query.preload('photos')
  }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865


  // before delete, delete photo
  @afterDelete()
  public static async deletePhoto(instance: Store) {
    var photo = await Image.findBy('relatedId', instance.id)
    if (photo) {
      await photo.delete()
    }
  }
<<<<<<< HEAD
  /**
   * set photo from MultipartFile
   * @param {MultipartFileContract} image
   * @param {boolean} [deleteOld=false]
   * @returns {Promise<Image>}
   */
  public async setPhoto(image: MultipartFileContract, deleteOld: boolean = true): Promise<Image> {
    var currentPhoto = await Image.query().where('related_type', 'stores:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: `${Store.table}:photo`,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
  }

=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
