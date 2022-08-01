import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

/**
 * CreateProductValidator
 */
export class CreateProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    name: schema.string.optional(),
    description: schema.string.optional(),
    photo: schema.file.optional({}, [
    ]),
  })

  public messages = {}
}

/**
 * UpdateProductValidator
 */
export class UpdateProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
    // photo is optional, but if it is provided, it must be a valid image
    photo: schema.file.optional(),
  })

  public messages = {}
}
/**
 * Show Product Validator
 *
 */
export class ShowProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["parent", "children", "translations", "photo"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Product Validator
 */
export class DestroyProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Products Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListProductsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional([
      rules.range(1, Infinity),
    ]),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(['name', 'description', 'created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_by: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum(["name", "description"] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["parent", "children", "translations", "photo"] as const)
    ),
    where: schema.object.optional().members({
      name: schema.string.optional(),
      description: schema.string.optional(),
    })
  })

  public messages = {}
}
