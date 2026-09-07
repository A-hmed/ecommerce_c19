import 'package:ecommerce_c19/features/auth/domain/repostiory/auth_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  Future<ApiResult<void>> call(LoginRequest request) =>
      _authRepository.login(request);
}
