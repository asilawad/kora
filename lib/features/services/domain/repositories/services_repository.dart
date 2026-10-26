import '../../../../core/error/result.dart';
import '../entities/services_page_entity.dart';
import '../entities/services_query.dart';

abstract interface class ServicesRepository {
  Future<Result<ServicesPageEntity>> getServices(ServicesQuery query);
}
