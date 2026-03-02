import 'package:book_store/src/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

 Future<dynamic> get({required String endPoint}) async {
    var response = await _dio.get(ApiConstants.baseURL + endPoint);

    return response.data;
  }
}
