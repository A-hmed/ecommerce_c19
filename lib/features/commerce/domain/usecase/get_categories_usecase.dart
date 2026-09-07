import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase{
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<ApiResult<List<Category>>> call() => _repository.getCategories();
}