import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<AuthResponse>> login(LoginRequest request);
  Future<ApiResult<AuthResponse>> register(RegisterRequest request);
}
