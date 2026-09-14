import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/commerce/domain/repository/home_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository _homeRepository;

  GetProductsUseCase(this._homeRepository);

  Future<ApiResult<List<Product>>> call() => _homeRepository.getProducts();
}
