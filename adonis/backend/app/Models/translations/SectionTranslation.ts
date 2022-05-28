
import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../dot/models/DorBaseModel'
import Section from '../Section'

export default class SectionTranslation extends DotBaseModel {
  @column()
  public locale: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public sectionId: string

  @belongsTo(() => Section)
  public section: BelongsTo<typeof Section>
}