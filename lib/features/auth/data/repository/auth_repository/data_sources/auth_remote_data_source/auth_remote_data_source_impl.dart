import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/auth/data/repository/auth_repository/data_sources/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/apis/api_services.dart';
import 'package:ecommerce_c19/features/network/handle_dio_errors.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiServices _apiServices;

  AuthRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try{
      AuthResponse authResponse = await _apiServices.login(request);
      return SuccessApiResult(authResponse);
    }on DioException catch(e){
      return handleDioError(e);
    }

  }
}
