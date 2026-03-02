import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioException ex) {
    switch (ex.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(ex.response!.statusCode!, ex.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection error');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');

      case DioExceptionType.unknown:
      default:
        return ServerFailure('Unexpected error occurred');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response)
  {
    if(statusCode==429)
    {
      return ServerFailure('Too Many Requests');
    }
    if(statusCode==404)
    {
      return ServerFailure('Request not found');
    }
    return ServerFailure('oops! Try later');
  }
}
