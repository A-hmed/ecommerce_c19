import 'package:ecommerce_c19/features/commerce/data/mappers/categories_mapper.dart';
import 'package:ecommerce_c19/features/commerce/data/mappers/products_mapper.dart';
import 'package:ecommerce_c19/features/commerce/data/repository/home_repository/data_soruces/home_remote_data_source/home_remote_data_source.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final CategoriesMapper _categoriesMapper;
  final ProductsMapper _productsMapper;

  HomeRepositoryImpl(
    this._remoteDataSource,
    this._categoriesMapper,
    this._productsMapper,
  );

  @override
  Future<ApiResult<List<Category>>> getCategories() async {
    try {
      var apiResult = await _remoteDataSource.getCategories();
      if (apiResult.isSuccess) {
        return SuccessApiResult(
          data: _categoriesMapper.toEntities(apiResult.getData()!.categories!),
        );
      } else {
        return FailureApiResult(apiResult.getError()!);
      }
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<List<Product>>> getProducts({
    String? category,
    String? subCategory,
  }) async {
    try {
      var apiResult = await _remoteDataSource.getProducts(
        category: category,
        subCategory: subCategory,
      );
      if (apiResult.isSuccess) {
        return SuccessApiResult(
          data: _productsMapper.toEntities(apiResult.getData()!.products!),
        );
      } else {
        return FailureApiResult(apiResult.getError()!);
      }
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<List<Category>>> getSubCategories(String categoryId) async {
    try {
      var apiResult = await _remoteDataSource.getSubCategories(categoryId);
      if (apiResult.isSuccess) {
        return SuccessApiResult(
          data: _categoriesMapper.toEntities(apiResult.getData()?.categories ?? []),
        );
      } else {
        return FailureApiResult(apiResult.getError()!);
      }
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
