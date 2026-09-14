import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/categories/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/products/products_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<CategoriesResponse>> getCategories();

  Future<ApiResult<ProductsResponse>> getProducts();
}
