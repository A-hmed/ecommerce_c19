import 'package:ecommerce_c19/core%20/utils/app_constants.dart';
import 'package:ecommerce_c19/core%20/utils/app_error.dart';

class ApiResult<T> {
  bool get isError => this is FailureApiResult;

  bool get isSuccess => this is SuccessApiResult;

  T get data => (this as SuccessApiResult).successData;

  AppErrors get error => (this as FailureApiResult).appError;
}

class SuccessApiResult<T> extends ApiResult<T> {
  T successData;

  SuccessApiResult(this.successData);
}

class FailureApiResult<T> extends ApiResult<T> {
  AppErrors appError;

  FailureApiResult(this.appError);
}


