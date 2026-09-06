import 'package:ecommerce_c19/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  ///This method will be used by ViewModel(cubit)
  Future<ApiResult<void>> call(LoginRequest request) =>
      _repository.login(request);
}
