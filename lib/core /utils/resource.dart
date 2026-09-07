class Resource<T>{
  String? errorMessage;
  ApiStatus status = ApiStatus.initial;
  T? data;

  Resource.initial(){
    status = ApiStatus.initial;
    errorMessage = null;
  }
  Resource.success(this.data){
    status = ApiStatus.success;
    errorMessage = null;
  }
  Resource.error(this.errorMessage){
    status = ApiStatus.error;
    data = null;
  }
  Resource.loading(){
    status = ApiStatus.loading;
    data = null;
    errorMessage = null;
  }

}
// dynamic(runtime) vs generics(compile)

enum ApiStatus{
  initial, loading, success, error;
}