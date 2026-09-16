import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  Dio get dio {
    var dio = Dio(BaseOptions(baseUrl: 'https://ecommerce.routemisr.com/api/v1/'));
    dio.interceptors.add(LanguageInterceptor());
    if(kDebugMode){
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }
}
class LanguageInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"language": "en"});
    // handler.next(options);
    super.onRequest(options, handler);
  }
}