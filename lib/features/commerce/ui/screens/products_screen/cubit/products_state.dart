import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class ProductsState {
  late Resource<List<Product>> productsApi;

  ProductsState({required this.productsApi});

  ProductsState.initial() {
    productsApi = Resource.initial();
  }

  ProductsState copyWith({Resource<List<Product>>? productsApi}) {
    return ProductsState(
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
