import 'package:ecommerce_c19/features/commerce/data/usecase/get_categories_usecase.dart';
import 'package:ecommerce_c19/features/commerce/data/usecase/get_products_usecase.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  HomeCubit(this._getCategoriesUseCase, this._getProductsUseCase)
      : super(HomeState.initial());

  Future<void> loadHomeData() async {
    loadCategories();
    loadProducts();
  }

  Future<void> loadCategories() async {
    emit(state.copyWith(categoriesApi: Resource.loading()));
    var apiResult = await _getCategoriesUseCase();
    if (apiResult.isSuccess) {
      emit(state.copyWith(categoriesApi: Resource.success(data: apiResult.getData())));
    } else {
      emit(state.copyWith(categoriesApi: Resource.error(errorMessage: apiResult.errorMessage)));
    }
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(productsApi: Resource.loading()));
    var apiResult = await _getProductsUseCase();
    if (apiResult.isSuccess) {
      emit(state.copyWith(productsApi: Resource.success(data: apiResult.getData())));
    } else {
      emit(state.copyWith(productsApi: Resource.error(errorMessage: apiResult.errorMessage)));
    }
  }
}
