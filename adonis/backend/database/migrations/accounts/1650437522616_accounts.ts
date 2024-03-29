import { Knex } from 'knex';
import SubAccountSchema from '../../../dot/SubAccountsSchema'

export default class Accounts extends SubAccountSchema {
  protected tableName = 'accounts'
  public usePivotTable: boolean = true
  public useUserRelation: boolean= true

  public setup(table: Knex.CreateTableBuilder): void {
    // account_type should be enum (personal, business, company)
    table.string('name').notNullable()
    table.string('description').nullable()
    table.json('data').nullable()
    table.integer('type').notNullable()
  }

}
