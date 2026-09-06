import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'api_services.g.dart';


@RestApi()
@injectable
abstract class ApiServices {

  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST('auth/signin')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('auth/signup')
  Future<AuthResponse> register(@Body() RegisterRequest request);
}