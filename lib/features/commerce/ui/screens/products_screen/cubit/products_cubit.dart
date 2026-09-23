import 'package:ecommerce_c19/features/commerce/data/usecase/get_products_usecase.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit(this._getProductsUseCase) : super(ProductsState.initial());

  Future<void> loadProducts({
    required String categoryId,
    required String? subCategoryId,
  }) async {
    emit(state.copyWith(productsApi: Resource.loading()));
    var result = await _getProductsUseCase(
      category: categoryId,
      subCategory: subCategoryId,
    );
    if (result.isSuccess) {
      emit(state.copyWith(
        productsApi: Resource.success(data: result.getData()),
      ));
    } else {
      emit(state.copyWith(
        productsApi: Resource.error(errorMessage: result.errorMessage),
      ));
    }
  }
}
