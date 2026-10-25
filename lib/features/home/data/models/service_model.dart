import '../../domain/entities/service_entity.dart';
import 'attribute_display_model.dart';
import 'home_json_keys.dart';
import 'service_attributes_model.dart';
import 'service_category_ref_model.dart';
import 'service_image_model.dart';
import 'staff_ref_model.dart';

final class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.durationMinutes,
    required super.durationLabel,
    required super.price,
    required super.finalPrice,
    required super.capacity,
    required super.isGroup,
    required super.image,
    required super.thumb,
    required super.images,
    required super.attributes,
    required super.attributesDisplay,
    required super.category,
    required super.staff,
    required super.isFeatured,
    super.description,
    super.salePrice,
    super.discountPercent,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final rawAttributes = json[HomeJsonKeys.attributes];
    final attributes = rawAttributes is Map<String, dynamic>
        ? ServiceAttributesModel.fromJson(rawAttributes)
        : const ServiceAttributesModel();
    return ServiceModel(
      id: json[HomeJsonKeys.id] as int,
      name: json[HomeJsonKeys.name] as String,
      slug: json[HomeJsonKeys.slug] as String,
      description: json[HomeJsonKeys.description] as String?,
      durationMinutes: json[HomeJsonKeys.durationMinutes] as int,
      durationLabel: json[HomeJsonKeys.durationLabel] as String,
      price: json[HomeJsonKeys.price] as num,
      salePrice: json[HomeJsonKeys.salePrice] as num?,
      finalPrice: json[HomeJsonKeys.finalPrice] as num,
      discountPercent: json[HomeJsonKeys.discountPercent] as int?,
      capacity: json[HomeJsonKeys.capacity] as int,
      isGroup: json[HomeJsonKeys.isGroup] as bool,
      image: json[HomeJsonKeys.image] as String,
      thumb: json[HomeJsonKeys.thumb] as String,
      images: (json[HomeJsonKeys.images] as List)
          .map(
            (item) => ServiceImageModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      attributes: attributes,
      attributesDisplay: (json[HomeJsonKeys.attributesDisplay] as List)
          .map(
            (item) =>
                AttributeDisplayModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      category: ServiceCategoryRefModel.fromJson(
        json[HomeJsonKeys.category] as Map<String, dynamic>,
      ),
      staff: (json[HomeJsonKeys.staff] as List)
          .map((item) => StaffRefModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      isFeatured: json[HomeJsonKeys.isFeatured] as bool,
    );
  }
}
