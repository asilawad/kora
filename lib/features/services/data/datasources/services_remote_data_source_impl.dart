import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/services_query.dart';
import '../models/services_page_model.dart';
import 'services_remote_data_source.dart';

final class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  const ServicesRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<ServicesPageModel>> getServices(ServicesQuery query) async {
    final result = await _dioClient.get(
      ApiConstants.services,
      query: _queryParameters(query),
    );
    return switch (result) {
      Success<ApiResponse>(:final data) => _parse(data),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  Map<String, dynamic> _queryParameters(ServicesQuery query) {
    final parameters = <String, dynamic>{
      ApiQuery.page: query.page,
      ApiQuery.perPage: query.perPage,
      ApiQuery.sort: query.sort.apiValue,
    };
    final search = query.search.trim();
    if (search.isNotEmpty) parameters[ApiQuery.search] = search;
    if (query.categoryId != null) {
      parameters[ApiQuery.categoryId] = query.categoryId;
    }
    if (query.sort.apiOrder != null) {
      parameters[ApiQuery.order] = query.sort.apiOrder;
    }
    return parameters;
  }

  Result<ServicesPageModel> _parse(ApiResponse response) {
    final data = response.data;
    if (data is! List || response.meta.isEmpty) {
      return const Failed(UnknownFailure());
    }
    try {
      return Success(
        ServicesPageModel.fromJson({
          ApiResponseKeys.data: data,
          ApiResponseKeys.meta: response.meta,
        }),
      );
    } on FormatException catch (error) {
      return Failed(UnknownFailure(message: error.message));
    } on TypeError catch (error) {
      return Failed(UnknownFailure(message: error.toString()));
    }
  }
}
