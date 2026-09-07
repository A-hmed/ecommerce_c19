import 'package:ecommerce_c19/core%20/utils/resource.dart';

class LoginState {
  late Resource<void> loginApi;

  LoginState({required this.loginApi});

  LoginState.initial() {
    loginApi = Resource.initial();
  }
}
