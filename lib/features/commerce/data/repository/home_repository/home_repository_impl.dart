import 'package:ecommerce_c19/features/commerce/data/mapper/category_mapper.dart';
import 'package:ecommerce_c19/features/commerce/data/mapper/product_mapper.dart';
import 'package:ecommerce_c19/features/commerce/data/repository/home_repository/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final CategoryMapper _categoryMapper;
  final ProductMapper _productMapper;

  HomeRepositoryImpl(
      this._remoteDataSource, this._productMapper, this._categoryMapper);

  @override
  Future<ApiResult<List<Category>>> getCategories() async {
    try {
      var response = await _remoteDataSource.getCategories();
      return SuccessApiResult(
          data: _categoryMapper.toEntityList(response.getData()?.categories));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<List<Product>>> getProducts() async {
    try {
      var response = await _remoteDataSource.getProducts();
      return SuccessApiResult(
          data: _productMapper.toEntityList(response.getData()?.products));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
