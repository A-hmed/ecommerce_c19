import 'package:ecommerce_c19/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/login/cubit/login_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginState(loginApi: Resource.initial()));


  ///This method will be used by widget
  login(String email, String password) async {
    emit(LoginState(loginApi: Resource.loading()));
   var apiResult = await _loginUseCase.call(LoginRequest(email: email, password: password));
   if(apiResult.isSuccess){
     emit(LoginState(loginApi: Resource.success()));
   }else{
     emit(LoginState(loginApi: Resource.error(errorMessage: apiResult.errorMessage)));
   }

  }
}