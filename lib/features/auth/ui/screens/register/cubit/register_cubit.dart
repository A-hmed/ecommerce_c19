import 'package:ecommerce_c19/features/auth/domain/usecase/register_usecase.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/register/cubit/register_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase)
      : super(RegisterState(registerApi: Resource.initial()));

  ///This method will be used by widget
  register({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(RegisterState(registerApi: Resource.loading()));
    var apiResult = await _registerUseCase.call(
      RegisterRequest(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      ),
    );
    if (apiResult.isSuccess) {
      emit(RegisterState(registerApi: Resource.success()));
    } else {
      emit(
        RegisterState(
          registerApi: Resource.error(errorMessage: apiResult.errorMessage),
        ),
      );
    }
  }
}
