import 'dart:convert';

import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:auto_sdk_core/auto_sdk_core.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import '../address/model.dart';
import '../customer_profile/model.dart';
import '../file/model.dart';
import '../order_item/model.dart';

part 'model.g.dart';

@Table(semantics: SemanticCardMetaData(title: "id", subtitle: "createdAt"))
class Order extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String addressId;
  @Column.required()
  final String customerProfileId;
  @Column()
  final OrderStatus status;

  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? validatedAt;
  @Column()
  final DateTime? deletedAt;
  @Column()
  final DateTime? closedAt;

  @HasMany(from: "OrderItem")
  final List<OrderItem>? items;

  @HasOne(from: "Address")
  final Address? address;

  @HasOne(from: "CustomerProfile")
  final CustomerProfile? customerProfile;

  Order({
    required this.id,
    required this.addressId,
    required this.customerProfileId,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.validatedAt,
    this.deletedAt,
    this.closedAt,
    this.items,
    this.address,
    this.customerProfile,
  });

  factory Order.fromMap(Map<String, dynamic> map) => Orders.modelFromMap(map);
  Map<String, dynamic> toMap() => Orders.modelToMap(this);
}

enum OrderStatus {
  pending,
  active,
  inactive,
  suspended,
}

class OrderItem extends Model {
  final String productId;
  final int quantity;
  final double price;
  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  OrderItem copyWith({
    String? productId,
    int? quantity,
    double? price,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['product_id'] as String,
      quantity: map['quantity'] as int,
      price: double.tryParse(map['price'].toString()) as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderItem(productId: $productId, quantity: $quantity, price: $price)';

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode ^ price.hashCode;
}
