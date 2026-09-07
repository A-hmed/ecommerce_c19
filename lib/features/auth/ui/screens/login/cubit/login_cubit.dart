import 'package:ecommerce_c19/core%20/utils/resource.dart';
import 'package:ecommerce_c19/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/login/cubit/login_state.dart';
import 'package:ecommerce_c19/features/network/model/request/auth/login_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginState.initial());

  login(String email, String password) async {
    emit(LoginState(loginApi: Resource.loading()));
    var apiResult = await _loginUseCase(
      LoginRequest(email: email, password: password),
    );
    if (apiResult.isError) {
      emit(LoginState(loginApi: Resource.error(apiResult.error.errorMessage)));
    } else {
      emit(LoginState(loginApi: Resource.success(null)));
    }
  }
}
