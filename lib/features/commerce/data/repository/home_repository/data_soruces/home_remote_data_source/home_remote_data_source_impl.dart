import 'package:ecommerce_c19/features/commerce/data/repository/home_repository/data_soruces/home_remote_data_source/home_remote_data_source.dart';
import 'package:ecommerce_c19/features/network/api/api_services.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/categories/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/products/products_response.dart';
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
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<ProductsResponse>> getProducts({
    String? category,
    String? subCategory,
  }) async {
    try {
      print("31- category = $category");
      var response = await _apiServices.getProducts(
        category: category,
        // subCategory: subCategory,
      );
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<CategoriesResponse>> getSubCategories(String categoryId) async {
    try {
      var response = await _apiServices.getSubCategories(categoryId);
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }
}
