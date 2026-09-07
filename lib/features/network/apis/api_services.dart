import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://ecommerce.routemisr.com/api/v1')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST('/auth/signin')
  Future<AuthResponse> login(@Body() LoginRequest request);

}
