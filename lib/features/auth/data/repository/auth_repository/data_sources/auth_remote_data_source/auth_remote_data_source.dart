import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';

abstract class AuthRemoteDataSource{
  Future<ApiResult<AuthResponse>> login(LoginRequest request);
}
