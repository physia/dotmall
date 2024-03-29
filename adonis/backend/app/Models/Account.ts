<<<<<<< HEAD
import { afterDelete, BaseModel, beforeFetch, belongsTo, BelongsTo, column, hasOne, HasOne, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import { usedPivot, usePivot } from 'Dot/hooks/orm'
import { DateTime } from 'luxon'
=======
import { afterDelete, beforeFetch, BelongsTo, belongsTo, column, hasOne, HasOne, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import { usedPivot, usePivot } from 'Dot/hooks/orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import DotBaseModel from '../../dot/models/DotBaseModel'
import { BusinessAccountData } from './accounts/business/BusinessAccountData'
import { PersonalAccountData } from './accounts/PersonalAccountData'
import CustomerProfile from './accounts/profiles/CustomerProfile'
import MerchantProfile from './accounts/profiles/MerchantProfile'
import { Image } from './File'
import User from './User'
<<<<<<< HEAD
import Phone from './ContactOptions/Phone'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'

=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
export default class Account extends DotBaseModel {
  static table: string = 'accounts'
  @column()
  public type: AccountType

  @column()
  public name: string

  @column()
  public description: string | null

  @column()
  public userId: string
<<<<<<< HEAD
=======
  @belongsTo(() => User)
  public users: BelongsTo<typeof User>
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  @column({
    prepare: (value: BusinessAccountData | PersonalAccountData) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public data: BusinessAccountData | PersonalAccountData

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>

  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Account>) {
    query.preload('photos')
  }

<<<<<<< HEAD
  @usedPivot(() => User, () => Phone)
  public users: ManyToMany<typeof User>
=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  @hasOne(() => CustomerProfile, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'accounts:customer')
      builder.preload('addresses')
      builder.preload('phones')
      builder.preload('emails')
    }
  })
  public customer: HasOne<typeof CustomerProfile>

  @hasOne(() => MerchantProfile, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'accounts:merchant')
      builder.preload('address')
      builder.preload('phones')
      builder.preload('emails')
      builder.preload('stores')
    }
  })
  public merchant: HasOne<typeof MerchantProfile>

  // before delete, delete photo
  @afterDelete()
  public static async deletePhoto(instance: Account) {
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
    var currentPhoto = await Image.query().where('related_type', 'accounts:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: `${Account.table}:photo`,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
  }
=======

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
export abstract class AccountData {
  constructor(data: any) {
    for (let key in data) {
      this[key] = data[key]
    }
  }
}

export enum AccountType {
<<<<<<< HEAD
  business = 'business',
  personal = 'personal',
=======
  personal = 0,
  business = 1,
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
