import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/auth/data/repository/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_c19/features/network/api/api_services.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth_response.dart';
import 'package:ecommerce_c19/features/network/utils/handle_dio_error.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  ///This is created by retrofit
  final ApiServices _apiServices;

  AuthRemoteDataSourceImpl(this._apiServices);

  ///This method will be user by repository
  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try {
      var authResponse = await _apiServices.login(request);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleDioError<AuthResponse>(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) async {
    try {
      var authResponse = await _apiServices.register(request);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleDioError<AuthResponse>(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
