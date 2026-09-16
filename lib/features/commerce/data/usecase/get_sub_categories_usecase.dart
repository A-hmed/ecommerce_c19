import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubCategoriesUseCase {
  final HomeRepository _homeRepository;

  GetSubCategoriesUseCase(this._homeRepository);

  Future<ApiResult<List<Category>>> call(String categoryId) =>
      _homeRepository.getSubCategories(categoryId);
}
