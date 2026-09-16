import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';

abstract class HomeRepository {
  Future<ApiResult<List<Category>>> getCategories();
  Future<ApiResult<List<Product>>> getProducts({
    String? category,
    String? subCategory,
  });
  Future<ApiResult<List<Category>>> getSubCategories(String categoryId);
}