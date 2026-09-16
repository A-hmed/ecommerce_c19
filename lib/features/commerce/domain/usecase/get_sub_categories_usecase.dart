import 'package:ecommerce_c19/features/commerce/domain/entity/sub_category.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubCategoriesUseCase {
  final HomeRepository _repository;

  GetSubCategoriesUseCase(this._repository);

  Future<ApiResult<List<SubCategory>>> call(String categoryId) =>
      _repository.getSubCategories(categoryId);
}
