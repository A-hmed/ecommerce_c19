import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';

abstract class AuthRepository {
  Future<ApiResult<void>> login(LoginRequest request);
  Future<ApiResult<void>> register(RegisterRequest request);
}
