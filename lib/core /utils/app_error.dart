import 'package:ecommerce_c19/core%20/utils/app_constants.dart';

class AppErrors {
  String errorMessage;

  AppErrors(this.errorMessage);
}

class NetworkError extends AppErrors {
  NetworkError({String errorMessage = AppConstants.networkErrorMessage})
    : super(errorMessage);
}

class ServerError extends AppErrors {
  ServerError({String? errorMessage = AppConstants.defaultErrorMessage})
    : super(errorMessage ?? AppConstants.defaultErrorMessage);
}

class SilentError extends AppErrors {
  SilentError({String errorMessage = AppConstants.defaultErrorMessage})
    : super(errorMessage);
}
