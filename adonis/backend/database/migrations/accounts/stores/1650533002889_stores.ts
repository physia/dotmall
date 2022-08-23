import DotBaseSchema from '../../../../dot/DotBaseSchema'
import { Knex } from 'knex'
import { LucidModel } from '@ioc:Adonis/Lucid/Orm'
import Category from 'App/Models/Category'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'

export default class Stores extends DotBaseSchema {
  protected tableName = 'stores'
  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public useTranslation = 'store'
  public useStatus: boolean = true
  public useRelations = [Category, MerchantProfile]
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('name').notNullable()
    table.string('description', 500).nullable()
  }
}
