import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class ProductsState {
  final Resource<List<Product>> productsApi;

  const ProductsState({required this.productsApi});

  factory ProductsState.initial() => ProductsState(
        productsApi: Resource.initial(),
      );

  ProductsState copyWith({
    Resource<List<Product>>? productsApi,
  }) {
    return ProductsState(
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
