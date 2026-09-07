import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/category/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/product/products_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<CategoriesResponse>> getCategories();

  Future<ApiResult<ProductsResponse>> getProducts();
}
