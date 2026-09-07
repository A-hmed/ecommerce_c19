import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';

FailureApiResult<T> handleDioError<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError:
      return FailureApiResult(NetworkError());

    case DioExceptionType.badResponse:
      var json = e.response?.data as Map?;
      return FailureApiResult(ServerError(message: json?["message"]));

    default:
      return FailureApiResult(ServerError());
  }
}