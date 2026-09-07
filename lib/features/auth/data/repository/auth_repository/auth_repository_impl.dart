import 'package:ecommerce_c19/features/auth/data/repository/auth_repository/data_sources/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_c19/features/auth/domain/repostiory/auth_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<ApiResult<void>> login(LoginRequest request) {
    ///todo: cache user data
    return _authRemoteDataSource.login(request);
  }

}