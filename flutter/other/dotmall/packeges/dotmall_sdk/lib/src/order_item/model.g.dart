// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// OrderItems
class OrderItems extends Collection<OrderItem> {
  OrderItems(this.manager);

  final Manager manager;

  final String table = "order_items";

  final String scope = "order_items";

  SemanticCardMetaData semanticsOf(OrderItem model) {
    return SemanticCardMetaData<String?, String?, File?>(
      title: null,
      subtitle: null,
      image: null,
    );
  }

  @override
  PaginatedModel<OrderItem> paginatedModelFromMap(Map<String, dynamic> map) {
    return PaginatedOrderItem.fromMap(map);
  }

  OrderItems copyWith({Manager? manager}) {
    return OrderItems(manager ?? this.manager);
  }

  OrderItems copyWithConfigs(Configs? configs) {
    return OrderItems(this.manager.copyWith(configs: configs));
  }

  @override
  OrderItem singleModelFromMap(Map<String, dynamic> map) {
    return OrderItem.fromMap(map["orderitem"]);
  }

  static OrderItem modelFromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map["id"],
      orderId: map["order_id"],
      productId: map["product_id"],
      quantity: map["quantity"],
      price: double.parse(map["price"].toString()),
    );
  }

  static Map<String, dynamic> modelToMap(OrderItem orderitem) {
    return {
      "id": orderitem.id,
      "order_id": orderitem.orderId,
      "product_id": orderitem.productId,
      "quantity": orderitem.quantity,
      "price": orderitem.price,
    };
  }

  Future<OrderItem> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["order_item"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<OrderItem> create(
      {required String orderId,
      required String productId,
      required int quantity,
      required double price,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (orderId != null) 'order_id': orderId,
          if (productId != null) 'product_id': productId,
          if (quantity != null) 'quantity': quantity,
          if (price != null) 'price': price,
        }),
      );
      return modelFromMap(response.data!["order_item"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<OrderItem> update(String id,
      {String? orderId,
      String? productId,
      int? quantity,
      double? price,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (orderId != null) 'order_id': orderId,
            if (productId != null) 'product_id': productId,
            if (quantity != null) 'quantity': quantity,
            if (price != null) 'price': price
          },
        ),
      );
      return modelFromMap(response.data!["order_item"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedOrderItem> list(
      {int? page = 1,
      int? limit = 24,
      OrderItemSortables? sort,
      SortOrder? order,
      String? search,
      OrderItemSearchables? searchIn,
      Map<OrderItemFields, String>? where,
      RequestOptions? options}) async {
    try {
      assert(
          (search == null && searchIn == null) ||
              (search != null && searchIn != null),
          'search and searchIn must be used together');
      options = options ?? RequestOptions();
      var response = await listR(
          options: options.copyWithAdded(queryParameters: {
        if (page != null) 'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (sort != null) 'sort': sort.name,
        if (order != null) 'order': order.name,
        if (search != null) 'search': search,
        if (searchIn != null) 'searchIn': searchIn.name,
        // [where] is a map of [OrderItemFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedOrderItem.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// OrderItemListOptions
class OrderItemListOptions extends RequestOptions {
  OrderItemListOptions(
      {int? page = 1,
      int? limit = 24,
      OrderItemSortables? sort,
      SortOrder? order,
      String? search,
      OrderItemSearchables? searchIn,
      Map<OrderItemFields, String>? where,
      Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
          if (page != null) 'page': page.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (sort != null) 'sort': sort.name,
          if (order != null) 'order': order.name,
          if (search != null) 'search': search,
          if (searchIn != null) 'searchIn': searchIn.name,
          // [where] is a map of [OrderItemFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        });
}

/// OrderItemFindOptions
class OrderItemFindOptions extends RequestOptions {
  OrderItemFindOptions(
      {Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
        });
}

/// OrderItemRelations
// no relations
/// OrderItemFilterables
enum OrderItemFilterables { id, orderId, productId, quantity, price }

/// OrderItemSortables
enum OrderItemSortables { id, orderId, productId, quantity, price }

/// OrderItemSearchables
enum OrderItemSearchables { id, orderId, productId, quantity, price }

/// OrderItemFields
enum OrderItemFields { id, orderId, productId, quantity, price }

/// OrderItemTranslatables
// no fields
/// OrderItemAuthCredentials
// no fields
/// PaginatedOrderItem
class PaginatedOrderItem extends PaginatedModel<OrderItem> {
  PaginatedOrderItem({required this.data, required this.meta});

  final List<OrderItem> data;

  final PaginationMeta meta;

  static PaginatedOrderItem fromMap(Map<String, dynamic> map) {
    return PaginatedOrderItem(
      data: List<OrderItem>.from(map['data'].map((x) => OrderItem.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// OrderItemExtentions
extension OrderItemExtensions on OrderItem {}
