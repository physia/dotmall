import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:auto_sdk_core/auto_sdk_core.dart';

import '../file/model.dart';

part 'model.g.dart';

@Table()
class StoreTranslation extends Model implements ModelTranslation {
  @Column.primary()
  final String id;
  @override
  @Column.required(useEnumValue: true)
  final Languages locale;
  @Column()
  final String name;
  @Column()
  final String? description;
  @Column.required()
  final String storeId;
  StoreTranslation({
    required this.id,
    required this.storeId,
    required this.name,
    this.description,
    required this.locale,
  });
  factory StoreTranslation.fromMap(Map<String, dynamic> map) =>
      StoreTranslations.modelFromMap(map);
  Map<String, dynamic> toMap() => StoreTranslations.modelToMap(this);
}
