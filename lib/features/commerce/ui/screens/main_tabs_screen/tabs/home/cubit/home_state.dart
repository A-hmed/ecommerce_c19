import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class HomeState {
  late Resource<List<Category>> categoriesApi;
  late Resource<List<Product>> productsApi;

  HomeState({required this.categoriesApi, required this.productsApi});

  HomeState.initial(){
    categoriesApi = Resource.initial();
    productsApi = Resource.initial();
  }

  HomeState copyWith({Resource<List<Category>>? categoriesApi,
    Resource<List<Product>>? productsApi}) {
    return HomeState(categoriesApi: categoriesApi ?? this.categoriesApi,
        productsApi: productsApi ?? this.productsApi);
  }
}