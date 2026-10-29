import 'package:equatable/equatable.dart';

class RelatedServiceEntity extends Equatable {
  const RelatedServiceEntity({
    required this.id,
    required this.name,
    required this.thumb,
    required this.durationMinutes,
    required this.finalPrice,
    required this.price,
    this.salePrice,
    this.discountPercent,
  });

  final int id;
  final String name;
  final String thumb;
  final int durationMinutes;
  final num finalPrice;
  final num price;
  final num? salePrice;
  final int? discountPercent;

  @override
  List<Object?> get props => [
    id,
    name,
    thumb,
    durationMinutes,
    finalPrice,
    price,
    salePrice,
    discountPercent,
  ];
}
