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
  Future<ApiResult<ProductsResponse>> getProducts() async {
    try {
      var response = await _apiServices.getProducts();
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }
}
