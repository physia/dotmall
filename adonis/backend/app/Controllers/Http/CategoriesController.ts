import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import  { CreateCategoryValidator, DestroyCategoryValidator, ListCategoriesValidator, ShowCategoryValidator, UpdateCategoryValidator } from 'App/Validators/CategoryValidator'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Category from 'App/Models/Category';

export default class CategoriesController {
  /**
    * returns the user's categories as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof CategoriesController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/categories
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListCategoriesValidator)
    await bouncer.with('CategoryPolicy').authorize('viewList', payload)
    var categoriesQuery = Category.query()
    var page = 1
    var limit = 24

    if (payload.search) {
      for (let i = 0; i < payload.search_by!.length; i++) {
        const element = payload.search_by![i];
        if (i == 0) {
          categoriesQuery = categoriesQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          categoriesQuery = categoriesQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      categoriesQuery = categoriesQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        categoriesQuery = categoriesQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        categoriesQuery = categoriesQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await categoriesQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new category for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ category: ModelObject; photo: Image | null; }>}
   * @memberof CategoriesController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Category", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/categories
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ category: ModelObject; photo: Image | null; }> {

    await bouncer.with('CategoryPolicy').authorize('create', null)
    const payload = await request.validate(CreateCategoryValidator)
    const category = await Category.create({
      name: payload.name,
      description: payload.description,
    })
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await category.setPhoto(payload.photo)
    }
    return {
      category: category.toJSON(),
      photo: photo,
    }
  }

  /**
   * returns the category info
   * @param {HttpContextContract}
   * @returns {Promise<Category>}
   * @memberof CategoriesController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/categories/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowCategoryValidator)
    var category = (await Category.find(payload.params.id))!
    await bouncer.with('CategoryPolicy').authorize('view', category)
    if (payload.load) {
      for (const load of payload.load) {
        await category.load(load)
      }
    }
    if (!payload.load?.includes('photo')) {
      await category.load('photo')
    }
    return category.toJSON()
  }

  /**
   * updates the category info
   * @param {HttpContextContract}
   * @returns {Promise<Category>}
   * @memberof CategoriesController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Category", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/categories/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateCategoryValidator)
    const category = (await Category.find(payload.params.id))!
    await bouncer.with('CategoryPolicy').authorize('update', category)
    category.name = payload.name ?? category.name
    category.description = payload.description ?? category.description
    await category.save()
    var photo: Image | null = null;
    if (payload.photo) {
      await category.setPhoto(payload.photo)
    }
    return {
      category: category.toJSON(),
      photo: photo,
    }
  }

  /**
   * deletes the category
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof CategoriesController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/categories/{categoryId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyCategoryValidator)
    const category = (await Category.find(payload.params.id))!
    await bouncer.with('CategoryPolicy').authorize('delete', category)
    return await category.delete()
  }


}
