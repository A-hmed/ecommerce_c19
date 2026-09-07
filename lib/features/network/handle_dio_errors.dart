import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core%20/utils/app_error.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';

ApiResult<T> handleDioError<T>(DioException e){
  switch(e.type){
    case DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionTimeout:
      return FailureApiResult(NetworkError());
    default:
      var json = e.response?.data;
      var message = json["message"];
      return FailureApiResult(ServerError(errorMessage: message));
  }
}