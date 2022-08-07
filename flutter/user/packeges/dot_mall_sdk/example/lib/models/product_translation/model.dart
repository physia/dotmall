import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:dot_mall_sdk/dot_mall_sdk.dart';

part 'model.g.dart';

@Table()
class ProductTranslation extends Model implements ModelTranslation {
  @Column.primary()
  final String id;
  @override
  @Column.required()
  final Languages locale;
  @Column()
  final String name;
  @Column()
  final String? description;
  @Column.required()
  final String productId;
  ProductTranslation({
    required this.id,
    required this.productId,
    required this.name,
    this.description,
    required this.locale,
  });
  factory ProductTranslation.fromMap(Map<String, dynamic> map) =>
      ProductTranslations.modelFromMap(map);
  @override
  Map<String, dynamic> toMap() => ProductTranslations.modelToMap(this);
}
