import DotBaseSchema from '../../../../dot/DotBaseSchema'
import { Knex } from 'knex'

export default class Stores extends DotBaseSchema {
  protected tableName = 'stores'
  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public useTranslation = 'store'
  public useStatus: boolean = true
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('name').notNullable()
    table.string('description', 500).nullable()
    // Geo location
    table.string('merchant_profile_id').references('merchant_profiles.id').onDelete('CASCADE') // delete when user is deleted
  }
}
