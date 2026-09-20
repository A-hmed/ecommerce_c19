import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/shared_pref_utils/shared_pref_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  Dio get dio {
    var dio = Dio(BaseOptions(baseUrl: 'https://ecommerce.routemisr.com/api/v1/'));

    dio.interceptors.add(AuthInterceptor());
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
    return dio;
  }
}

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var prefs = getIt<SharedPrefUtils>();
    options.headers.addAll({"token": await prefs.getToken()});
    super.onRequest(options, handler);
  }
}
