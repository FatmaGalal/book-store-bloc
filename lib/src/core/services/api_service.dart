import 'package:book_store/src/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> get({
    required String endPoint,
    required int startIndex,
    Map<String, dynamic>? queryParameters,
  }) async {
    final mergedQueryParameters = <String, dynamic>{};
    if (queryParameters != null) {
      mergedQueryParameters.addAll(queryParameters);
    }
    mergedQueryParameters['startIndex'] = startIndex;

    var response = await _dio.get(
      ApiConstants.baseURL + endPoint,
      queryParameters: mergedQueryParameters,
    );
    return response.data;
  }
}
