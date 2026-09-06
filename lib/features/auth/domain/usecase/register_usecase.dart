import 'package:ecommerce_c19/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  ///This method will be used by ViewModel(cubit)
  Future<ApiResult<void>> call(RegisterRequest request) =>
      _repository.register(request);
}
