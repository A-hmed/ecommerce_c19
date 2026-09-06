import 'package:ecommerce_c19/core/shared_pref_utils/shared_pref_utils.dart';
import 'package:ecommerce_c19/features/auth/data/repository/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_c19/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SharedPrefUtils _sharedPrefUtils;

  AuthRepositoryImpl(this._authRemoteDataSource, this._sharedPrefUtils);

  ///This method will be used by UseCase
  @override
  Future<ApiResult<void>> login(LoginRequest request) async {
    var apiResult = await _authRemoteDataSource.login(request);
    if (apiResult.isSuccess && apiResult.getData()?.token != null) {
      _sharedPrefUtils.saveToken(apiResult.getData()!.token!);
    }
    return apiResult;
  }

  @override
  Future<ApiResult<void>> register(RegisterRequest request) async {
    var apiResult = await _authRemoteDataSource.register(request);
    if (apiResult.isSuccess && apiResult.getData()?.token != null) {
      _sharedPrefUtils.saveToken(apiResult.getData()!.token!);
    }
    return apiResult;
  }
}
