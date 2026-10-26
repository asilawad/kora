import '../../../../core/constants/api_constants.dart';
import '../../../home/data/models/service_model.dart';
import '../../domain/entities/services_page_entity.dart';

final class ServicesPageModel extends ServicesPageEntity {
  const ServicesPageModel({
    required super.items,
    required super.page,
    required super.perPage,
    required super.total,
    required super.lastPage,
  });

  factory ServicesPageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json[ApiResponseKeys.data] as List;
    final rawMeta = json[ApiResponseKeys.meta] as Map<String, dynamic>;
    return ServicesPageModel(
      items: rawItems
          .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      page: rawMeta[ApiResponseKeys.page] as int,
      perPage: rawMeta[ApiResponseKeys.perPage] as int,
      total: rawMeta[ApiResponseKeys.total] as int,
      lastPage: rawMeta[ApiResponseKeys.lastPage] as int,
    );
  }
}
