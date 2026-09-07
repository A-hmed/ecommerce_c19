import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/commerce/data/repository/home_repository/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:ecommerce_c19/features/network/api/api_services.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/category/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/product/products_response.dart';
import 'package:ecommerce_c19/features/network/utils/handle_dio_error.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices _apiServices;

  HomeRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<CategoriesResponse>> getCategories() async {
    try {
      var response = await _apiServices.getCategories();
      return SuccessApiResult(data: response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<ProductsResponse>> getProducts() async {
    try {
      var response = await _apiServices.getProducts();
      return SuccessApiResult(data: response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
