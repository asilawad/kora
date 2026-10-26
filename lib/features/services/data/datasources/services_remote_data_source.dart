import '../../../../core/error/result.dart';
import '../../domain/entities/services_query.dart';
import '../models/services_page_model.dart';

abstract interface class ServicesRemoteDataSource {
  Future<Result<ServicesPageModel>> getServices(ServicesQuery query);
}
