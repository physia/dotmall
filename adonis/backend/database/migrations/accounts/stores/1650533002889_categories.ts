import DotBaseSchema from '../../../../dot/DotBaseSchema'
import { Knex } from 'knex'

export default class Categories extends DotBaseSchema {
  protected tableName = 'categories'
  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public useTranslation = 'category'
  public useStatus: boolean = true
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('name').notNullable()
    table.string('description', 500).nullable()
    table.string('slug').nullable().unique()
    table.string('category_id').references('categories.id').onDelete('CASCADE')
  }
}
