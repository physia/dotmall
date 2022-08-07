import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:dot_mall_sdk/dot_mall_sdk.dart';

part 'model.g.dart';

@Table()
class SectionTranslation extends Model implements ModelTranslation {
  @Column.primary()
  final String id;
  @Column.required()
  final Languages locale;
  @Column()
  final String name;
  @Column()
  final String? description;
  @Column.required()
  final String sectionId;
  SectionTranslation({
    required this.id,
    required this.sectionId,
    required this.name,
    this.description,
    required this.locale,
  });
  factory SectionTranslation.fromMap(Map<String, dynamic> map) =>
      SectionTranslations.modelFromMap(map);
  Map<String, dynamic> toMap() => SectionTranslations.modelToMap(this);
}
