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
  Future<ApiResult<ProductsResponse>> getProducts({
    String? category,
    String? subCategory,
  }) async {
    try {
      print("category = $category");
      print("subcategory = $subCategory");
      var response = await _apiServices.getProducts(
        category: category,
       // subCategory: subCategory,
      );
      return SuccessApiResult(data: response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<CategoriesResponse>> getSubCategories(String categoryId) async {
    try {
      var response = await _apiServices.getSubCategoriesByCategory(categoryId);
      return SuccessApiResult(data: response);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
