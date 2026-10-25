import 'package:equatable/equatable.dart';

import 'attribute_display_entity.dart';
import 'service_category_ref_entity.dart';
import 'service_attributes_entity.dart';
import 'service_image_entity.dart';
import 'staff_ref_entity.dart';

class ServiceEntity extends Equatable {
  const ServiceEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.durationMinutes,
    required this.durationLabel,
    required this.price,
    required this.finalPrice,
    required this.capacity,
    required this.isGroup,
    required this.image,
    required this.thumb,
    required this.images,
    required this.attributes,
    required this.attributesDisplay,
    required this.category,
    required this.staff,
    required this.isFeatured,
    this.description,
    this.salePrice,
    this.discountPercent,
  });

  final int id;
  final String name;
  final String slug;
  final String? description;
  final int durationMinutes;
  final String durationLabel;
  final num price;
  final num? salePrice;
  final num finalPrice;
  final int? discountPercent;
  final int capacity;
  final bool isGroup;
  final String image;
  final String thumb;
  final List<ServiceImageEntity> images;
  final ServiceAttributesEntity attributes;
  final List<AttributeDisplayEntity> attributesDisplay;
  final ServiceCategoryRefEntity category;
  final List<StaffRefEntity> staff;
  final bool isFeatured;

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    description,
    durationMinutes,
    durationLabel,
    price,
    salePrice,
    finalPrice,
    discountPercent,
    capacity,
    isGroup,
    image,
    thumb,
    images,
    attributes,
    attributesDisplay,
    category,
    staff,
    isFeatured,
  ];
}
