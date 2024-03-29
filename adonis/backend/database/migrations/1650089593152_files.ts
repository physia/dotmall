import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class Files extends DotBaseSchema {
  protected tableName = 'files'
  public useTimestamps = true
  public useSoftDeletes = true
<<<<<<< HEAD
  public useRelatedTo = true
=======
  public useUserRelation = true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  public usePivotTable = true
  // public useTranslation = true
  public setup(table: Knex.CreateTableBuilder): void {
    /// this tible is for storing files
    table.string('name').nullable()
    table.string('description').nullable()
    table.string('path').nullable()
    table.string('mime').nullable()


    // table.string('type').nullable()
    // table.string('size').nullable()
    // table.string('extension').nullable()
    // table.string('mime').nullable()
  }
}
